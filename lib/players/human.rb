module Players
    #   inherits from Player
    class Human < Player

    # move
    # asks the user for input and returns it
    def move(board)
        puts "Please enter 1-9:"
        gets.strip
      end
    end
  end