require 'bundler/setup'
require 'curses'

file_name = ARGV[0]

(puts "file name is required"; exit) unless file_name
(puts "#{file_name} not exists"; exit) unless File.exist?(file_name)

file = File.read(file_name)
lines = file.each_line.to_a

Curses.init_screen
Curses.start_color
# Curses.use_default_colors

offset = (Curses.lines - lines.count) / 2
(puts "file lines is larger than screen hight"; exit) if offset < 0

###playground###==========###
# $col_a = [
#   Curses::COLOR_BLACK, Curses::COLOR_BLUE, Curses::COLOR_CYAN, Curses::COLOR_GREEN,
#   Curses::COLOR_MAGENTA, Curses::COLOR_RED, Curses::COLOR_WHITE, Curses::COLOR_YELLOW
# ]

###=======================###

#=init colors=#
Curses.init_pair(1, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
#=============#

Curses.setpos(offset, 0)
lines.each{|line|
  line.chars.each{|char|
    if char.match(/[0-9A-Z]/)
      Curses.attron(Curses.color_pair(1))
      Curses.addch(char)
      Curses.attroff(Curses.color_pair(1))
    else
      Curses.addch(char)
    end
  }
}

Curses.noecho
while true
  key = Curses.getch
  current_position = {y: Curses.stdscr.cury, x: Curses.stdscr.curx}
  case key
  when 'q'
    break
  when 'h'
    Curses.setpos(current_position[:y], current_position[:x] - 1)
  when 'j'
    Curses.setpos(current_position[:y] + 1, current_position[:x])
  when 'k'
    Curses.setpos(current_position[:y] - 1, current_position[:x])
  when 'l'
    Curses.setpos(current_position[:y], current_position[:x] + 1)
  end

  if Curses.inch != 32
    Curses.setpos(current_position[:y], current_position[:x])
  end
end

Curses.close_screen
