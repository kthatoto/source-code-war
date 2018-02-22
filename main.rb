require 'bundler/setup'
require 'curses'
require 'syntax/convertors/html'
require 'syntax'
require 'colorize'

file_name = ARGV[0]
unless file_name
  puts "file name is required"
  exit
end
unless File.exist?(file_name)
  puts "#{file_name} not exists"
  exit
end
# String.color_samples
tokenizer = Syntax.load('ruby')
tokenizer.tokenize( File.read( file_name ) ) do |token|
  # puts "group(#{token.group}, #{token.instruction}) lexeme(#{token})"
  case token.group
  when :ident, :normal
    print token.to_s
  when :punct
    print token.to_s.light_green
  when :symbol
    print token.to_s.magenta
  end
end

# file = File.read(file_name)
# lines = file.each_line.to_a
#
# lines.each {|line| puts line}
