#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
SKILLS_DIR = File.join(ROOT, "skills")

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
skill_directory_names = skill_dirs.map { |path| File.basename(path) }

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

end

names.each do |name, directories|
  next if directories.length == 1

  errors << "#{name}: duplicate source skill name in #{directories.join(', ')}"
end

unless errors.empty?
  warn errors.map { |error| "- #{error}" }.join("\n")
  exit 1
end

puts "Validated #{skill_dirs.length} source skills."
