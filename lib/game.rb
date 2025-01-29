class Game
  def initialize
    @board = Board.new
    create_players

  end

  def create_players
    # player 1
    print "Enter player 1's name: "
    name1 = gets.chomp
    print "Enter symbol for #{name1} (X or O): "
    symbol1 = gets.chomp.upcase until %w[X O].include?(symbol1)

    # player 2
    symbol2 = symbol1 == "X" ? "O" : "X" # opposite symbol of player 1
    print "Enter player 2's name: "
    name2 = gets.chomp

    player1 = Player.new(name1, symbol1)
    player2 = Player.new(name2, symbol2) 

    @players = [player1, player2] # store both players in an array
    @current_player = @players.first # start with player 1

    puts ""
    puts "#{@players[0].name} will be playing as #{symbol1}."
    puts "#{@players[1].name} will be playing as #{symbol2}."
  end

  def switch_turns
    @players.rotate!
    @current_player = @players.first
  end

  def game_over?
    if @board.winning_combo?(@current_player.symbol)
      puts "Game over. #{@current_player.name} wins!"
      return true
    elsif @board.full?
      puts "Game over. It's a tie..."
      return true
    end
    false # game is not over
  end

  def play_turn()
    print "Your turn, #{@current_player.name}. Choose a position: "
    position = gets.chomp.upcase

    if position == 'EXIT' || position == 'QUIT'
      puts "Exiting the game. Goodbye!"
      exit
    end

    # try placing symbol; if invalid, re-prompt
    until @board.valid_move?(position)
      print "Invalid move! Try again: "
      position = gets.chomp.upcase
    end

    # place current player's symbol in position they chose
    @board.place_symbol(position, @current_player.symbol)

    @board.display

  end

  def start
    puts ""
    puts "Type 'exit' anytime to quit the game."

    # check for exit before starting
    print "Ready to start? (Y to start, 'exit' to quit): "
    answer = gets.chomp.downcase
    if answer == 'exit' || answer == 'quit'
      puts "Exiting the game. Goodbye!"
      exit
    end

    puts "Let the game begin!"
    @board.display

    until game_over?
      play_turn
      break if game_over? # ensures game stops right after a win
      switch_turns
    end

    play_again?
  end

  def play_again?
    print "Play again? (Y or N): "
    @response = gets.chomp.upcase

    until %w[Y N EXIT QUIT].include?(@response)
      print "Invalid choice! Choose Y or N: "
      @response = gets.chomp.upcase
    end

    if @response == "Y"
      print "Do you want to keep the same players? (Y or N): "
      keep_players = gets.chomp.upcase

      if keep_players == "Y"
        puts "Starting new game... winner goes first! Start us off, #{@current_player.name}!"
      else
        puts "Please enter new player names and symbols."
        create_players# reinitialize players
      end

      @board = Board.new # reset the board
      start # start the new game
    else
      puts "Goodbye. Thanks for playing!"
    end
      
  end
end