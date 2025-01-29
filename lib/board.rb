class Board 

  def initialize
    @grid = {
      "A1" => " ", "A2" => " ", "A3" => " ",
      "B1" => " ", "B2" => " ", "B3" => " ",
      "C1" => " ", "C2" => " ", "C3" => " "
    }
  end

  def place_symbol(position, symbol)
    # validate move
    if valid_move?(position)
      @grid[position] = symbol
      true # move valid
    else
      false # move invalid
    end
  end

  def valid_move?(position)
    @grid.key?(position) && @grid[position] == " "
  end

  def full?
    !@grid.values.include?(" ")
  end

  def winning_combo?(symbol)
    winning_combinations = [
      # Rows
      ["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
      # Columns
      ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"],
      # Diagonals
      ["A1", "B2", "C3"], ["A3", "B2", "C1"]
    ]

    winning_combinations.any? do |combo|
      combo.all? { |pos| @grid[pos] == symbol }
    end
  end
  
  def display
    # print out board
    puts "   1   2   3"
    puts "A  #{@grid["A1"]} | #{@grid["A2"]} | #{@grid["A3"]} "
    puts "  ---+---+---"
    puts "B  #{@grid["B1"]} | #{@grid["B2"]} | #{@grid["B3"]} "
    puts "  ---+---+---"
    puts "C  #{@grid["C1"]} | #{@grid["C2"]} | #{@grid["C3"]} "
  end
end