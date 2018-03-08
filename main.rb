require 'bundler/setup'
require 'curses'
Dir[File.expand_path('../classes', __FILE__) << '/*.rb'].each{|file| require file}
file_path = ARGV[0]
(puts "file name is required"; exit) unless file_path
(puts "#{file_path} not exists"; exit) unless File.exist?(file_path)

Curses.init_screen
Curses.noecho
Curses.start_color
Curses.use_default_colors

field = Field.new(file_path)
player = Player.new(field)
loop do
  field.draw
  player.draw
  if key = player.getch
    break if key == ?q
    player.command(key)
  end
  sleep 0.01
end
Curses.close_screen

# TODO: when file size is larger than terminal height
# (puts "file lines is larger than screen hight"; exit) if offset < 0

###playground###==========###
# $col_a = [
#   Curses::COLOR_BLACK, Curses::COLOR_BLUE, Curses::COLOR_CYAN, Curses::COLOR_GREEN,
#   Curses::COLOR_MAGENTA, Curses::COLOR_RED, Curses::COLOR_WHITE, Curses::COLOR_YELLOW
# ]

#[reference] https://docs.ruby-lang.org/ja/2.0.0/class/Curses.html#M_COLOR_CONTENT

###=======================###

#=init colors=#
# Curses.init_pair(1, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
# Curses.init_pair(2, Curses::COLOR_RED, Curses::COLOR_YELLOW)
#=============#
