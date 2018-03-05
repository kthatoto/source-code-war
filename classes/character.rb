class Character
  def initialize
    @class_name = 'character'
  end
  def describe_myself
    puts "I'm class of #{@class_name}"
  end
  def describe_all_other_classes
    window = Window.new
    window.describe_myself
    player = Player.new
    player.describe_myself
    puts 'and'
    describe_myself
  end
end
