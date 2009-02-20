#!/usr/bin/env ruby

# Complete rake tasks script for bash
# Save it somewhere and then add
# complete -C path/to/script -o default rake
# to your ~/.bashrc
# Francis Hwang ( http://fhwang.net/ ) building on work of 
# Nicholas Seckar <nseckar@gmail.com>

require 'fileutils'

RAKEFILES = ['rakefile', 'Rakefile', 'rakefile.rb', 'Rakefile.rb']
exit 0 unless RAKEFILES.any? { |rf| File.file?(File.join(Dir.pwd, rf)) }
exit 0 unless /^rake(?:\s+([-\w]+))?\s*$/ =~ ENV["COMP_LINE"]
# exit 0 unless /^rake(?:\s+-\w+)?(?:\s+([-:\w]+))?\s*$/ =~ ENV["COMP_LINE"]  # PAJ
task_prefix = $1

cache_dir = File.join( ENV['HOME'], '.rake', 'tc_cache' )
FileUtils.mkdir_p cache_dir
rakefile = RAKEFILES.detect { |rf| File.file?(File.join(Dir.pwd, rf)) }
rakefile_path = File.join( Dir.pwd, rakefile )
cache_file = File.join( cache_dir, rakefile_path.gsub( %r{/}, '_' ) )
if File.exist?( cache_file ) &&
   File.mtime( cache_file ) >= File.mtime( rakefile )
  task_lines = File.read( cache_file )
else
  task_lines = `rake --tasks`
  File.open( cache_file, 'w' ) do |f| f << task_lines; end
end

tasks = task_lines.split("\n")[1..-1].collect {|line| line.split[1]}
tasks = tasks.select {|t| /^#{Regexp.escape task_prefix}/ =~ t} if task_prefix
# tasks = tasks.map { |t| t.sub(/#{Regexp.escape task_prefix}/,'') } if task_prefix[-1] == ?:  # PAJ
puts tasks
# puts ARGV.inspect
exit 0

