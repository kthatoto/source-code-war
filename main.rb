require 'bundler/setup'
require 'curses'
Dir[File.expand_path('../classes', __FILE__) << '/*.rb'].each{|file| require file}
file_path = ARGV[0]
(puts "file name is required"; exit) unless file_path
(puts "#{file_path} not exists"; exit) unless File.exist?(file_path)

Curses.init_screen
window = Window.new(file_path)
window.draw
Curses.refresh
Curses.getch
Curses.close_screen
exit


# file = File.read(file_name)
# lines = file.each_line.to_a

# Curses.init_screen
Curses.start_color
Curses.use_default_colors

# offset = (Curses.lines - lines.count) / 2
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
Curses.init_pair(1, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
Curses.init_pair(2, Curses::COLOR_RED, Curses::COLOR_YELLOW)
#=============#

Curses.setpos(offset, 0)
lines.each{|line|
  line.chars.each{|char|
    if char.match(/[0-9]/)
      Curses.attron(Curses.color_pair(1))
      Curses.addch(char)
      Curses.attroff(Curses.color_pair(1))
    elsif char.match(/[C]/)
      Curses.attron(Curses.color_pair(2))
      Curses.addch(char)
      Curses.attroff(Curses.color_pair(2))
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
