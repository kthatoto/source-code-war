require 'bundler/setup'
require 'curses'
require 'syntax/convertors/html'

file_name = ARGV[0]
unless file_name
  puts "file name is required"
  exit
end
unless File.exist?(file_name)
  puts "#{file_name} not exists"
  exit
end
file = File.read(file_name)
lines = file.each_line.to_a

lines.each {|line| puts line}
