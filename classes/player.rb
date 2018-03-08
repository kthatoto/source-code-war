class Player
  @@move_chars = {h: :left, j: :down, k: :up, l: :right}
  @@directions = {
    left: {y: 0, x: -1, direction: '<'},
    down: {y: 1, x: 0,  direction: 'v'},
    up: {y: -1, x: 0, direction: '^'},
    right: {y: 0, x: 1,  direction: '>'}
  }
  def initialize(field)
    @window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @window.nodelay = 1
    @field = field
    @posy = field.get_bottom_posy
    @posx = 0
    @direction = :up
  end

  def getch
    @window.getch
  end

  def draw
    @window.setpos(@posy, @posx)
    @window.delch
    @window.insch(@@directions[@direction][:direction])
  end

  def command(key)
    if move = @@directions[@@move_chars[key.to_sym]]
      if @field.exists_space?(@posy + move[:y], @posx + move[:x])
        @posy += move[:y]
        @posx += move[:x]
      end
      @window.delch
      @direction = @@move_chars[key.to_sym]
    end
    if key == "c"
      if @field.exists_space?(@posy, @posx)
        `echo c >> log.txt`
      end
    end
    if key == "d"
      if @field.exists_space?(@posy, @posx)
        `echo d >> log.txt`
      end
    end
  end
end
