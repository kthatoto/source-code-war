require 'curses'
require 'pp'

file = File.read('pattern.rb')
lines = file.each_line.to_a

lines.each {|line| puts line}
