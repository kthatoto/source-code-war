require 'bundler/setup'
require 'curses'

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

# lines.each {|line| puts line}

Curses.init_screen
offset = (Curses.lines - lines.count) / 2
if offset < 0
  puts "file lines is larger than screen hight"
  exit
end
Curses.setpos(offset, 0)
lines.each{|line| Curses.addstr(line)}

Curses.noecho
while true
  key = Curses.getch
  case key
  when 'q'
    break
  when 'h'
    Curses.setpos(Curses.stdscr.cury, Curses.stdscr.curx - 1)
  when 'j'
    Curses.setpos(Curses.stdscr.cury + 1, Curses.stdscr.curx)
  when 'k'
    Curses.setpos(Curses.stdscr.cury - 1, Curses.stdscr.curx)
  when 'l'
    Curses.setpos(Curses.stdscr.cury, Curses.stdscr.curx + 1)
  end

  if Curses.inch != 32
  case key
    when 'h'
      Curses.setpos(Curses.stdscr.cury, Curses.stdscr.curx + 1)
    when 'j'
      Curses.setpos(Curses.stdscr.cury - 1, Curses.stdscr.curx)
    when 'k'
      Curses.setpos(Curses.stdscr.cury + 1, Curses.stdscr.curx)
    when 'l'
      Curses.setpos(Curses.stdscr.cury, Curses.stdscr.curx - 1)
    end
  end
end

Curses.close_screen
