#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "shellwords"
require "tmpdir"

ROOT = File.expand_path("..", __dir__)

class InstallSkillsTest < Minitest::Test
  def test_install_updates_tracked_skills_then_mirrors_every_source_skill
    with_repository do |repo, home, bin, log|
      write_skill(repo, "second", "second local version")
      installed = File.join(home, ".agents", "skills")
      FileUtils.mkdir_p(File.join(installed, "first"))
      File.write(File.join(installed, "first", "SKILL.md"), "old version")
      File.write(File.join(installed, "first", "legacy.txt"), "legacy")
      FileUtils.mkdir_p(File.join(installed, "unrelated"))
      File.write(File.join(installed, "unrelated", "keep.txt"), "keep")
      FileUtils.mkdir_p(File.join(installed, "retired"))
      File.write(File.join(installed, "retired", "keep.txt"), "former")
      FileUtils.mkdir_p(File.join(home, ".agents"))
      File.write(File.join(home, ".agents", ".skill-lock.json"), "locked")
      commit(repo, "add second source skill")

      result = run_make(repo, home, bin, log, "install", "FAKE_NPX_OVERWRITE" => "first")

      assert_predicate result, :success?, result.output
      assert_equal ["validate", "update --global --yes"], File.readlines(log, chomp: true)
      assert_equal "local version\n", File.read(File.join(installed, "first", "content.txt"))
      assert_equal "second local version\n", File.read(File.join(installed, "second", "content.txt"))
      refute File.exist?(File.join(installed, "first", "legacy.txt"))
      assert_equal "keep", File.read(File.join(installed, "unrelated", "keep.txt"))
      assert_equal "former", File.read(File.join(installed, "retired", "keep.txt"))
      assert_equal "locked", File.read(File.join(home, ".agents", ".skill-lock.json"))
    end
  end

  def test_install_requires_clean_local_main_before_validation
    changes = {
      "another branch" => lambda { |repo| git(repo, "switch", "--quiet", "-c", "feature") },
      "a staged change" => lambda do |repo|
        File.write(File.join(repo, "staged.txt"), "dirty")
        git(repo, "add", "staged.txt")
      end,
      "an unstaged change" => lambda do |repo|
        File.open(File.join(repo, "skills", "first", "content.txt"), "a") { |file| file << "dirty" }
      end,
      "an untracked change" => lambda { |repo| File.write(File.join(repo, "untracked.txt"), "dirty") }
    }

    changes.each do |description, change|
      with_repository do |repo, home, bin, log|
        change.call(repo)

        result = run_make(repo, home, bin, log, "install")

        refute_predicate result, :success?, "accepted #{description}"
        refute File.exist?(log), "ran validation for #{description}"
        refute Dir.exist?(File.join(home, ".agents")), "mutated global state for #{description}"
      end
    end
  end

  def test_validation_and_global_update_failures_stop_before_reconciliation
    with_repository do |repo, home, bin, log|
      skill = File.join(repo, "skills", "first", "SKILL.md")
      File.write(skill, "invalid source skill\n")
      commit(repo, "break source validation")

      result = run_make(repo, home, bin, log, "install")

      refute_predicate result, :success?
      refute File.exist?(log), "global update ran after validation failed"
      refute Dir.exist?(File.join(home, ".agents")), "global state changed after validation failed"
    end

    with_repository do |repo, home, bin, log|
      target = File.join(home, ".agents", "skills", "first")
      FileUtils.mkdir_p(target)
      File.write(File.join(target, "content.txt"), "old\n")

      result = run_make(repo, home, bin, log, "install", "FAKE_NPX_FAIL" => "1")

      refute_predicate result, :success?
      assert_equal ["validate", "update --global --yes"], File.readlines(log, chomp: true)
      assert_equal "old\n", File.read(File.join(target, "content.txt"))
    end
  end

  def test_install_replaces_managed_files_and_links_without_following_links
    with_repository do |repo, home, bin, log|
      write_skill(repo, "second", "second local version")
      first_source = File.join(repo, "skills", "first")
      script = File.join(first_source, "run")
      File.write(script, "#!/bin/sh\n")
      FileUtils.chmod(0o755, script)
      File.symlink("content.txt", File.join(first_source, "content-link"))
      commit(repo, "add linked and executable source content")

      installed = File.join(home, ".agents", "skills")
      FileUtils.mkdir_p(installed)
      File.write(File.join(installed, "first"), "not a directory")
      external = File.join(home, "outside")
      FileUtils.mkdir_p(external)
      File.write(File.join(external, "keep.txt"), "outside")
      File.symlink(external, File.join(installed, "second"))

      result = run_make(repo, home, bin, log, "install")

      assert_predicate result, :success?, result.output
      assert File.directory?(File.join(installed, "first"))
      assert File.directory?(File.join(installed, "second"))
      refute File.symlink?(File.join(installed, "second"))
      assert_equal "outside", File.read(File.join(external, "keep.txt"))
      assert File.symlink?(File.join(installed, "first", "content-link"))
      assert_equal "content.txt", File.readlink(File.join(installed, "first", "content-link"))
      assert_equal 0o111, File.stat(File.join(installed, "first", "run")).mode & 0o111
    end
  end

  def test_install_repairs_stale_bytes_with_the_source_size_and_timestamp
    with_repository do |repo, home, bin, log|
      source = File.join(repo, "skills", "first", "content.txt")
      target = File.join(home, ".agents", "skills", "first", "content.txt")
      FileUtils.mkdir_p(File.dirname(target))
      File.write(target, "x" * File.size(source))
      source_stat = File.stat(source)
      File.utime(source_stat.atime, source_stat.mtime, target)

      result = run_make(repo, home, bin, log, "install")

      assert_predicate result, :success?, result.output
      assert_equal File.binread(source), File.binread(target)
    end
  end

  def test_install_preserves_other_permissions_and_reconciles_executability
    with_repository do |repo, home, bin, log|
      source = File.join(repo, "skills", "first")
      source_script = File.join(source, "run")
      File.write(source_script, "#!/bin/sh\n")
      FileUtils.chmod(0o755, source_script)
      commit(repo, "add executable source file")

      target = File.join(home, ".agents", "skills", "first")
      FileUtils.mkdir_p(target)
      target_content = File.join(target, "content.txt")
      target_script = File.join(target, "run")
      FileUtils.cp(File.join(source, "content.txt"), target_content)
      FileUtils.cp(source_script, target_script)
      FileUtils.chmod(0o600, [target_content, target_script])

      result = run_make(repo, home, bin, log, "install")

      assert_predicate result, :success?, result.output
      assert_equal 0o600, File.stat(target_content).mode & 0o777
      assert_equal 0o600, File.stat(target_script).mode & 0o666
      assert_equal 0o111, File.stat(target_script).mode & 0o111
    end
  end

  def test_final_verification_ignores_timestamps_but_rejects_content_differences
    with_repository do |repo, home, bin, log|
      result = run_make(repo, home, bin, log, "install")
      assert_predicate result, :success?, result.output

      target = File.join(home, ".agents", "skills", "first", "content.txt")
      future = Time.now + 3_600
      File.utime(future, future, target)
      write_fake_rsync_that_skips_copy(bin)

      result = run_make(repo, home, bin, log, "install")

      assert_predicate result, :success?, result.output
    end

    with_repository do |repo, home, bin, log|
      write_fake_rsync_that_skips_copy(bin)

      result = run_make(repo, home, bin, log, "install")

      refute_predicate result, :success?
      assert_includes result.output, "Managed Installed Skill first still differs"
    end
  end

  def test_bare_make_only_displays_available_targets
    with_repository do |repo, home, bin, log|
      result = run_make(repo, home, bin, log, nil)

      assert_predicate result, :success?, result.output
      %w[validate test-install test install].each { |target| assert_includes result.output, "make #{target}" }
      refute File.exist?(log)
      refute Dir.exist?(File.join(home, ".agents"))
    end
  end

  private

  Result = Struct.new(:status, :output, keyword_init: true) do
    def success?
      status.success?
    end
  end

  def with_repository
    Dir.mktmpdir("install-skills-test") do |root|
      repo = File.join(root, "repo")
      home = File.join(root, "home")
      bin = File.join(root, "bin")
      log = File.join(root, "npx.log")
      FileUtils.mkdir_p([repo, home, bin, File.join(repo, "test"), File.join(repo, "script")])
      FileUtils.cp(File.join(ROOT, "Makefile"), repo)
      FileUtils.cp(File.join(ROOT, "test", "validate_skills.rb"), File.join(repo, "test"))
      FileUtils.cp(File.join(ROOT, "script", "executable_bits.rb"), File.join(repo, "script"))
      write_skill(repo, "first", "local version")
      write_fake_npx(bin)
      git(repo, "init", "--quiet", "--initial-branch=main")
      commit(repo, "initial fixture")
      yield repo, home, bin, log
    end
  end

  def write_skill(repo, name, content)
    skill = File.join(repo, "skills", name)
    FileUtils.mkdir_p(File.join(skill, "agents"))
    File.write(File.join(skill, "SKILL.md"), <<~SKILL)
      ---
      name: #{name}
      description: Test source skill #{name}
      ---

      Test instructions.
    SKILL
    File.write(File.join(skill, "agents", "openai.yaml"), <<~YAML)
      interface:
        display_name: #{name}
        short_description: Test source skill used for installation
        default_prompt: Use $#{name} for this test.
      policy:
        allow_implicit_invocation: false
    YAML
    File.write(File.join(skill, "content.txt"), "#{content}\n")
  end

  def write_fake_npx(bin)
    path = File.join(bin, "npx")
    File.write(path, <<~'SH')
      #!/bin/sh
      set -eu

      case "$*" in
        "--yes skills@1.5.21 add . --list")
          printf '%s\n' validate >> "$FAKE_NPX_LOG"
          count=0
          names=
          for skill in skills/*/SKILL.md; do
            [ -f "$skill" ] || continue
            count=$((count + 1))
            names="${names}${skill#skills/}\n"
          done
          printf 'Found %s skills\n' "$count"
          printf '%b' "$names" | sed 's,/SKILL.md$,,'
          ;;
        "--yes skills@latest update --global --yes")
          printf '%s\n' "update --global --yes" >> "$FAKE_NPX_LOG"
          [ "${FAKE_NPX_FAIL:-}" != 1 ] || exit 19
          if [ -n "${FAKE_NPX_OVERWRITE:-}" ]; then
            target="$HOME/.agents/skills/$FAKE_NPX_OVERWRITE"
            mkdir -p "$target"
            printf '%s\n' remote > "$target/content.txt"
          fi
          ;;
        *)
          printf 'unexpected npx arguments: %s\n' "$*" >&2
          exit 64
          ;;
      esac
    SH
    FileUtils.chmod(0o755, path)
  end

  def write_fake_rsync_that_skips_copy(bin)
    real_rsync = ENV.fetch("PATH").split(File::PATH_SEPARATOR)
                    .map { |directory| File.join(directory, "rsync") }
                    .find { |path| File.executable?(path) }
    raise "rsync is unavailable" unless real_rsync

    path = File.join(bin, "rsync")
    File.write(path, <<~SH)
      #!/bin/sh
      case " $* " in
        *" --itemize-changes "*)
          PATH=#{Shellwords.escape(ENV.fetch("PATH"))}
          export PATH
          exec #{Shellwords.escape(real_rsync)} "$@"
          ;;
        *) exit 0 ;;
      esac
    SH
    FileUtils.chmod(0o755, path)
  end

  def run_make(repo, home, bin, log, target, env = {})
    stdout, stderr, status = Open3.capture3(
      {
        "HOME" => home,
        "PATH" => "#{bin}:#{ENV.fetch('PATH')}",
        "FAKE_NPX_LOG" => log
      }.merge(env),
      *(["make"] + Array(target)),
      chdir: repo
    )
    Result.new(status: status, output: "#{stdout}#{stderr}")
  end

  def commit(repo, message)
    git(repo, "add", ".")
    git(repo, "-c", "user.name=Test", "-c", "user.email=test@example.com", "commit", "--quiet", "-m", message)
  end

  def git(repo, *arguments)
    _stdout, stderr, status = Open3.capture3("git", *arguments, chdir: repo)
    assert_predicate status, :success?, stderr
  end
end
