require 'bundler/setup'
require 'curses'

file_name = ARGV[0]

(puts "file name is required"; exit) unless file_name
(puts "#{file_name} not exists"; exit) unless File.exist?(file_name)

file = File.read(file_name)
lines = file.each_line.to_a

Curses.init_screen
Curses.start_color
Curses.use_default_colors

offset = (Curses.lines - lines.count) / 2
# TODO: when file size is larger than terminal height
# (puts "file lines is larger than screen hight"; exit) if offset < 0

###playground###==========###
# $col_a = [
#   Curses::COLOR_BLACK, Curses::COLOR_BLUE, Curses::COLOR_CYAN, Curses::COLOR_GREEN,
#   Curses::COLOR_MAGENTA, Curses::COLOR_RED, Curses::COLOR_WHITE, Curses::COLOR_YELLOW
# ]

#参考 https://docs.ruby-lang.org/ja/2.0.0/class/Curses.html#M_COLOR_CONTENT

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
  break if key == 'q'
  move_chars = {
    h: {y: 0, x: -1, direction: '<'},
    j: {y: 1, x: 0,  direction: 'v'},
    k: {y: -1, x: 0, direction: '^'},
    l: {y: 0, x: 1,  direction: '>'}
  }
  if move_chars[key.to_sym]
    after_move_position = {
      y: current_position[:y] + move_chars[key.to_sym][:y],
      x: current_position[:x] + move_chars[key.to_sym][:x],
    }
    Curses.delch
    Curses.insch(" ")
    Curses.setpos(after_move_position[:y], after_move_position[:x])
    if Curses.inch != 32
      Curses.setpos(current_position[:y], current_position[:x])
    end
    Curses.delch
    Curses.insch(move_chars[key.to_sym][:direction])
  end

end

Curses.close_screen
