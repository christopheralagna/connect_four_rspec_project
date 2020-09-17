require 'pry'

class Game
  attr_accessor :winning_combinations, :board, :tie

  def initialize()
    @winning_combinations = [
      ["a1","a2","a3","a4"], ["a2","a3","a4","a5"], ["a3","a4","a5","a6"], #columns
      ["b1","b2","b3","b4"], ["b2","b3","b4","b5"], ["b3","b4","b5","b6"],
      ["c1","c2","c3","c4"], ["c2","c3","c4","c5"], ["c3","c4","c5","c6"],
      ["d1","d2","d3","d4"], ["d2","d3","d4","d5"], ["d3","d4","d5","d6"],
      ["e1","e2","e3","e4"], ["e2","e3","e4","e5"], ["e3","e4","e5","e6"],
      ["f1","f2","f3","f4"], ["f2","f3","f4","f5"], ["f3","f4","f5","f6"],
      ["g1","g2","g3","g4"], ["g2","g3","g4","g5"], ["g3","g4","g5","g6"],

      ["a1","b1","c1","d1"], ["a2","b2","c2","d2"], ["a3","b3","c3","d3"], #rows
      ["a4","b4","c4","d4"], ["a5","b5","c5","d5"], ["a6","b6","c6","d6"],
      ["b1","c1","d1","e1"], ["b2","c2","d2","e2"], ["b3","c3","d3","e3"],
      ["b4","c4","d4","e4"], ["b5","c5","d5","e5"], ["b6","c6","d6","e6"],
      ["c1","d1","e1","f1"], ["c2","d2","e2","f2"], ["c3","d3","e3","f3"],
      ["c4","d4","e4","f4"], ["c5","d5","e5","f5"], ["c6","d6","e6","f6"],
      ["d1","e1","f1","g1"], ["d2","e2","f2","g2"], ["d3","e3","f3","g3"],
      ["d4","e4","f4","g4"], ["d5","e5","f5","g5"], ["d6","e6","f6","g6"],

      ["a1","b2","c3","d4"], ["a2","b3","c4","d5"], ["a3","b4","c5","d6"], #diagonals
      ["b1","c2","d3","e4"], ["b2","c3","d4","e5"], ["b3","c4","d5","e6"],
      ["c1","d2","e3","f4"], ["c2","d3","e4","f5"], ["c3","d4","e5","f6"],
      ["d1","e2","f3","g4"], ["d2","e3","f4","g5"], ["d3","e4","f5","g6"],
  
      ["a4","b3","c2","d1"], ["a5","b4","c3","d2"], ["a6","b5","c4","d3"], 
      ["b4","c3","d2","e1"], ["b5","c4","d3","e2"], ["b6","c5","d4","e3"],
      ["c4","d3","e2","f1"], ["c5","d4","e3","f2"], ["c6","d5","e4","f3"],
      ["d4","e3","f2","g1"], ["d5","e4","f3","g2"], ["d6","e5","f4","g3"]
    ] 

    @board = {
      "a6" => "_", "b6" => "_", "c6" => "_", "d6" => "_", "e6" => "_", "f6" => "_", "g6" => "_",
      "a5" => "_", "b5" => "_", "c5" => "_", "d5" => "_", "e5" => "_", "f5" => "_", "g5" => "_",
      "a4" => "_", "b4" => "_", "c4" => "_", "d4" => "_", "e4" => "_", "f4" => "_", "g4" => "_",
      "a3" => "_", "b3" => "_", "c3" => "_", "d3" => "_", "e3" => "_", "f3" => "_", "g3" => "_",
      "a2" => "_", "b2" => "_", "c2" => "_", "d2" => "_", "e2" => "_", "f2" => "_", "g2" => "_",
      "a1" => "_", "b1" => "_", "c1" => "_", "d1" => "_", "e1" => "_", "f1" => "_", "g1" => "_",
    }

    @is_tie = false

  end

  def player_select(num)
    puts "\nPlayer #{num}, please type your name..."
    name = gets.chomp
    return Player.new(name, "0") if num == "1"
    return Player.new(name, "O") if num == "2"
  end

  def round(player); #contains all game functions
    puts display_board()
    slot = get_selection(player)
    player.positions = update_player(player, slot)
    @board = update_board(player, slot)
    player.wins = check_if_winner(player)
    @tie = check_if_tie(@board)
  end

  def display_board()
    "
      A   B   C   D   E   F   G  
    _____________________________
    |_#{board["a6"]}_|_#{board["b6"]}_|_#{board["c6"]}_|_#{board["d6"]}_|_#{board["e6"]}_|_#{board["f6"]}_|_#{board["g6"]}_|
    |_#{board["a5"]}_|_#{board["b5"]}_|_#{board["c5"]}_|_#{board["d5"]}_|_#{board["e5"]}_|_#{board["f5"]}_|_#{board["g5"]}_|
    |_#{board["a4"]}_|_#{board["b4"]}_|_#{board["c4"]}_|_#{board["d4"]}_|_#{board["e4"]}_|_#{board["f4"]}_|_#{board["g4"]}_|
    |_#{board["a3"]}_|_#{board["b3"]}_|_#{board["c3"]}_|_#{board["d3"]}_|_#{board["e3"]}_|_#{board["f3"]}_|_#{board["g3"]}_|
    |_#{board["a2"]}_|_#{board["b2"]}_|_#{board["c2"]}_|_#{board["d2"]}_|_#{board["e2"]}_|_#{board["f2"]}_|_#{board["g2"]}_|
    |_#{board["a1"]}_|_#{board["b1"]}_|_#{board["c1"]}_|_#{board["d1"]}_|_#{board["e1"]}_|_#{board["f1"]}_|_#{@board["g1"]}_|
    "
  end

  def get_selection(player)
    puts "\n#{player.name}, please enter a valid slot:"
    slot = gets.chomp
    until ("a".."g").any? { |letter| letter == slot }
      puts "Please enter a VALID slot:"
      slot = gets.chomp
    end
    return slot
  end

  def update_player(player, slot)
    for i in 1..6 do
      position = "#{slot}#{i.to_s}"
      if @board[position] == "_"
        return player.positions.push(position)
      end
    end
    player.positions #no change if stack is full
  end

  def update_board(player, slot)
    for i in 1..6 do
      position = "#{slot}#{i.to_s}"
      if @board[position] == "_"
        @board[position] = player.color
        return @board
      end
    end
    @board #no change if stack is full
  end

  def check_if_winner(player)
    return @winning_combinations.any? { |combination| combination.all? { |position| player.positions.include?(position.to_s) } }
  end

  def check_if_tie(board)
    return board.all? { |position, value| value != "_" }
  end

  def display_winner(player)
    puts "\nCongratulations #{player.name}, You Win!"
  end

  def display_tie()
    puts "\nThis game is a draw!"
  end
end

class Player
  attr_accessor :name, :color, :positions, :wins

  def initialize(name, color)
    @name = name
    @color = color
    @positions = []
    @wins = false
  end
end

game = Game.new
player1 = game.player_select('1')
player2 = game.player_select('2')
loop do
  game.round(player1)
    break if player1.wins || game.tie
  game.round(player2)
    break if player1.wins || game.tie
end
puts game.display_board
if player1.wins
  game.display_winner(player1)
elsif player2.wins
  game.display_winner(player2)
elsif game.tie
  game.display_tie()
end
