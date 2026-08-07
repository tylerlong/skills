#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
SKILLS_DIR = File.join(ROOT, "skills")
SKILLS_CLI_VERSION = "1.5.21"
ANSI_ESCAPE = /\e\[[0-?]*[ -\/]*[@-~]/

def nonempty_string?(value)
  value.is_a?(String) && !value.strip.empty?
end

def yaml_mapping(source, label, errors)
  value = YAML.safe_load(source)
  return value if value.is_a?(Hash)

  errors << "#{label}: must contain a YAML mapping"
  nil
rescue Psych::Exception => error
  errors << "#{label}: invalid YAML (#{error.message.lines.first.strip})"
  nil
end

def frontmatter(path, label, errors)
  content = File.read(path)
  match = content.match(/\A---\r?\n(.*?)\r?\n---(?:\r?\n|\z)/m)
  unless match
    errors << "#{label}: missing YAML frontmatter"
    return [nil, content]
  end

  [yaml_mapping(match[1], label, errors), content]
end

def check_reference(raw_target, skill_dir, label, errors)
  target = raw_target.strip
  target = target[1...-1] if target.start_with?("<") && target.end_with?(">")
  target = target.split(/\s+/, 2).first.to_s

  return if target.empty? || target.start_with?("#", "/")
  return if target.match?(/\A[a-z][a-z0-9+.-]*:/i)
  return if target.split("/").include?("..")

  target = target.split(/[?#]/, 2).first
  path = File.expand_path(target, skill_dir)
  owned = path == skill_dir || path.start_with?("#{skill_dir}#{File::SEPARATOR}")
  return unless owned
  return if File.exist?(path)

  errors << "#{label}: referenced file does not exist: #{target}"
end

errors = []
skill_dirs = if Dir.exist?(SKILLS_DIR)
               Dir.glob(File.join(SKILLS_DIR, "*")).select { |path| File.directory?(path) }.sort
             else
               []
             end

errors << "skills: no source skills found" if skill_dirs.empty?
names = Hash.new { |hash, name| hash[name] = [] }

skill_dirs.each do |skill_dir|
  directory_name = File.basename(skill_dir)
  skill_path = File.join(skill_dir, "SKILL.md")
  unless File.file?(skill_path)
    errors << "#{directory_name}: missing SKILL.md"
    next
  end

  skill, content = frontmatter(skill_path, directory_name, errors)
  if skill
    name = skill["name"]
    description = skill["description"]

    if nonempty_string?(name)
      names[name] << directory_name
      errors << "#{directory_name}: name must match its directory" unless name == directory_name
      unless name.length <= 64 && name.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
        errors << "#{directory_name}: name must be at most 64 lowercase letters, digits, and single hyphens"
      end
    else
      errors << "#{directory_name}: name must be a nonempty string"
    end

    errors << "#{directory_name}: description must be a nonempty string" unless nonempty_string?(description)
  end

  content.scan(/\[[^\]]*\]\(([^)\n]+)\)/).flatten.each do |target|
    check_reference(target, skill_dir, directory_name, errors)
  end

  agents_path = File.join(skill_dir, "agents", "openai.yaml")
  unless File.file?(agents_path)
    errors << "#{directory_name}: missing agents/openai.yaml"
    next
  end

  agents = yaml_mapping(File.read(agents_path), "#{directory_name}/agents/openai.yaml", errors)
  next unless agents

  interface = agents["interface"]
  policy = agents["policy"]
  unless interface.is_a?(Hash)
    errors << "#{directory_name}: agents interface must be a mapping"
    interface = {}
  end
  unless policy.is_a?(Hash)
    errors << "#{directory_name}: agents policy must be a mapping"
    policy = {}
  end

  errors << "#{directory_name}: display_name must be a nonempty string" unless nonempty_string?(interface["display_name"])

  short_description = interface["short_description"]
  unless nonempty_string?(short_description) && short_description.length.between?(25, 64)
    errors << "#{directory_name}: short_description must contain 25 to 64 characters"
  end

  default_prompt = interface["default_prompt"]
  unless nonempty_string?(default_prompt) && default_prompt.include?("$#{directory_name}")
    errors << "#{directory_name}: default_prompt must reference $#{directory_name}"
  end

  implicit = policy["allow_implicit_invocation"]
  unless implicit == true || implicit == false
    errors << "#{directory_name}: allow_implicit_invocation must be a boolean"
  end

  interface.values_at("icon_small", "icon_large").compact.each do |target|
    check_reference(target.to_s, skill_dir, directory_name, errors)
  end
end

names.each do |name, directories|
  next if directories.length == 1

  errors << "#{name}: duplicate source skill name in #{directories.join(', ')}"
end

unless errors.empty?
  warn errors.map { |error| "- #{error}" }.join("\n")
  exit 1
end

expected_names = names.keys.sort
begin
  stdout, stderr, status = Open3.capture3(
    { "NO_COLOR" => "1" },
    "npx", "--yes", "skills@#{SKILLS_CLI_VERSION}", "add", ".", "--list",
    chdir: ROOT
  )
rescue Errno::ENOENT => error
  warn "- Skills CLI could not run: #{error.message}"
  exit 1
end

output = "#{stdout}\n#{stderr}".gsub(ANSI_ESCAPE, "")
unless status.success?
  warn "- Skills CLI #{SKILLS_CLI_VERSION} failed\n#{output.strip}"
  exit 1
end

found_count = output[/Found\s+(\d+)\s+skills?/, 1]
errors << "Skills CLI did not report its discovered skill count" unless found_count
if found_count && found_count.to_i != expected_names.length
  errors << "Skills CLI found #{found_count} skills; expected #{expected_names.length}"
end

listed_lines = output.lines.map { |line| line.sub(/\A\s*│\s*/, "").strip }
expected_names.each do |name|
  count = listed_lines.count(name)
  errors << "Skills CLI listed #{name} #{count} times; expected once" unless count == 1
end

unless errors.empty?
  warn errors.map { |error| "- #{error}" }.join("\n")
  exit 1
end

puts "Validated #{expected_names.length} source skills with Skills CLI #{SKILLS_CLI_VERSION}."
