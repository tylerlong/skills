#!/usr/bin/env ruby
# frozen_string_literal: true

require "find"

command, source_root, target_root = ARGV
abort "usage: #{$PROGRAM_NAME} sync|verify SOURCE TARGET" unless %w[sync verify].include?(command) && target_root

different = false
Find.find(source_root) do |source|
  source_stat = File.lstat(source)
  next unless source_stat.file?

  relative = source[(source_root.length + 1)..-1]
  target = File.join(target_root, relative)
  target_stat = File.lstat(target)
  abort "#{relative}: target is not a regular file" unless target_stat.file?

  expected = source_stat.mode & 0o111
  actual = target_stat.mode & 0o111
  next if actual == expected

  if command == "sync"
    File.chmod((target_stat.mode & ~0o111) | expected, target)
  else
    warn "#{relative}: executable bits are #{actual.to_s(8)}; expected #{expected.to_s(8)}"
    different = true
  end
end

exit 1 if different
