class Field
  def initialize(file_path)
    @file_path = file_path
    load_file
    @offset = (Curses.lines - @lines.count) / 2
    @window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
  end
  def load_file
    file = File.read(@file_path)
    @lines = file.each_line.to_a
  end

  def draw
    @window.setpos(@offset, 0)
    @lines.each{|line|
      line.chars.each{|char|
        @window.addch(char)
      }
    }
    @window.refresh
  end
  def get_bottom_posy
    return @offset + @lines.count
  end
  def blank_pos?(y, x)
    !(@lines[y - @offset] && @lines[y - @offset].chars[x])
  end
end
