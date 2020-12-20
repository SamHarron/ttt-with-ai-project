class Game 
    # defines a constant WIN_COMBINATIONS with arrays for each win 
    # combination
    WIN_COMBINATIONS = [    
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [6,4,2]]

    # provides access to the board, player_1, and player_2
    attr_accessor :board, :player_1, :player_2

    #   initialize
    # accepts 2 players and a board 
    # defaults to two human players, X and O, with an empty board

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    # “?” mark in a ruby method indicates that method will return 
    # either true or false // player 1 or player 2.
    # returns the correct player, X, for the third move. Odd or Even.
    def current_player
        @board.turn_count % 2 == 0 ? player_1 : player_2
    end


    # The detect() of enumerable is an inbuilt method in Ruby returns 
    # the first element which satisfies the given condition in the block

      # won?
      # returns false for a draw
      # returns the correct winning combination in the case of a win
      # isn't hard-coded
    def won?
        WIN_COMBINATIONS.detect {|threerow|
            @board.cells[threerow[0]] == @board.cells[threerow[1]] &&
            @board.cells[threerow[1]] == @board.cells[threerow[2]] &&
            @board.taken?(threerow[0]+1)}
    end

    #   # draw?
    #   returns true for a draw
    #   returns false for a won game
    #   returns false for an in-progress game
    def draw?
        @board.full? && !won?
    end

    #   # over?
    #   returns true for a draw
    #   returns true for a won game
    #   returns false for an in-progress game
    def over?
        won? || draw?
    end

    #   # winner
    #   returns X when X won
    #   returns O when O won
    #   returns nil when no winner
    def winner
        if three_in_a_row = won?
          @winner = @board.cells[three_in_a_row.first]
        end
    end

    # turn
    # makes valid moves
    # asks for input again after a failed validation
    # changes to player 2 after the first turn
    def turn
        player = current_player
        current_move = player.move(@board)

        if !@board.valid_move?(current_move)
            turn
        else 
            puts "Turn: #{@board.turn_count+1}\n"
            @board.display
            @board.update(current_move, player)
            puts "#{player.token} moved #{current_move}"
            @board.display
            puts "\n\n"
        end
    end

    # play
    # asks for players input on a turn of the game
    # checks if the game is over after every turn
    # plays the first turn of the game
    # plays the first few turns of the game
    # checks if the game is won after every turn
    # checks if the game is a draw after every turn
    # stops playing if someone has won
    # congratulates the winner X
    # congratulates the winner O
    # stops playing in a draw
    # prints "Cat's Game!" on a draw
    # plays through an entire game
    def play
        while !over?
          turn
        end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end

      
end
