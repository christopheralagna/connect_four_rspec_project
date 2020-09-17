require './lib/connect_four.rb'

describe Game do
  game = Game.new
  player1 = Player.new('name','0')

  describe "#check_if_winner" do
    it "returns true if player @positions match VERTICAL @winning_combination ([a1,a2,a3,a4]) in ISOLATED SEQUENTIAL ORDER" do
      player1.positions = ['a1','a2','a3','a4']
      expect(game.check_if_winner(player1)).to eql(true)
    end

    it "returns true if player @positions match VERTICAL @winning_combination ([a1,a2,a3,a4]) in ISOLATED NONSEQUENTIAL ORDER" do
      player1.positions = ['a4','a2','a3','a1']
      expect(game.check_if_winner(player1)).to eql(true)
    end

    it "returns true if player @positions match VERTICAL @winning_combination ([a1,a2,a3,a4]) in SEPARATED SEQUENTIAL ORDER" do
      player1.positions = ['a1','b3','a2','g6','a3','f5','a4','e2']
      expect(game.check_if_winner(player1)).to eql(true)
    end

    it "returns true if player @positions match VERTICAL @winning_combination ([a1,a2,a3,a4]) in SEPARATED NONSEQUENTIAL ORDER" do
      player1.positions = ['a3','b3','a2','g6','a4','f5','a1','e2']
      expect(game.check_if_winner(player1)).to eql(true)
    end

    it "returns true if player @positions match HORIZONTAL @winning_combination ([b4,c4,d4,e4]) in SEPARATED NONSEQUENTIAL ORDER" do
      player1.positions = ['c4','a3','d4','b6','b4','g2','e4']
      expect(game.check_if_winner(player1)).to eql(true)
    end

    it "returns true if player @positions match DIAGONAL @winning_combination ([c5,d4,e3,f2]) in SEPARATED NONSEQUENTIAL ORDER" do
      player1.positions = ['d4','b3','f2','g6','e3','f5','c5','e2']
      expect(game.check_if_winner(player1)).to eql(true)
    end
  end

  describe "#update_board" do
    game.board = {
      "a6" => "_", "b6" => "_", "c6" => "0", "d6" => "_", "e6" => "_", "f6" => "_", "g6" => "_",
      "a5" => "_", "b5" => "_", "c5" => "O", "d5" => "_", "e5" => "_", "f5" => "_", "g5" => "_",
      "a4" => "_", "b4" => "_", "c4" => "O", "d4" => "0", "e4" => "_", "f4" => "_", "g4" => "_",
      "a3" => "_", "b3" => "_", "c3" => "0", "d3" => "O", "e3" => "_", "f3" => "_", "g3" => "O",
      "a2" => "_", "b2" => "O", "c2" => "0", "d2" => "0", "e2" => "_", "f2" => "_", "g2" => "0",
      "a1" => "0", "b1" => "O", "c1" => "O", "d1" => "O", "e1" => "0", "f1" => "_", "g1" => "0",
    }

    it "returns the updated board with token correctly placed on current stack" do
      expect(game.update_board(player1, "d")).to eql({
        "a6" => "_", "b6" => "_", "c6" => "0", "d6" => "_", "e6" => "_", "f6" => "_", "g6" => "_",
        "a5" => "_", "b5" => "_", "c5" => "O", "d5" => "0", "e5" => "_", "f5" => "_", "g5" => "_",
        "a4" => "_", "b4" => "_", "c4" => "O", "d4" => "0", "e4" => "_", "f4" => "_", "g4" => "_",
        "a3" => "_", "b3" => "_", "c3" => "0", "d3" => "O", "e3" => "_", "f3" => "_", "g3" => "O",
        "a2" => "_", "b2" => "O", "c2" => "0", "d2" => "0", "e2" => "_", "f2" => "_", "g2" => "0",
        "a1" => "0", "b1" => "O", "c1" => "O", "d1" => "O", "e1" => "0", "f1" => "_", "g1" => "0",
      })
    end

    it "returns the same board when stack is already full" do
      expect(game.update_board(player1, "c")).to eql({
        "a6" => "_", "b6" => "_", "c6" => "0", "d6" => "_", "e6" => "_", "f6" => "_", "g6" => "_",
        "a5" => "_", "b5" => "_", "c5" => "O", "d5" => "0", "e5" => "_", "f5" => "_", "g5" => "_",
        "a4" => "_", "b4" => "_", "c4" => "O", "d4" => "0", "e4" => "_", "f4" => "_", "g4" => "_",
        "a3" => "_", "b3" => "_", "c3" => "0", "d3" => "O", "e3" => "_", "f3" => "_", "g3" => "O",
        "a2" => "_", "b2" => "O", "c2" => "0", "d2" => "0", "e2" => "_", "f2" => "_", "g2" => "0",
        "a1" => "0", "b1" => "O", "c1" => "O", "d1" => "O", "e1" => "0", "f1" => "_", "g1" => "0",
      })
    end
  end

  describe "#display_board" do

    it "returns the correct visual image of board data" do
      expect(game.display_board).to eql(
      "
        A   B   C   D   E   F   G  
      _____________________________
      |___|___|___|___|___|___|___|
      |___|___|___|___|___|___|___|
      |___|___|___|___|___|___|___|
      |___|___|___|___|___|___|___|
      |___|___|___|___|___|___|___|
      |___|___|___|___|___|___|___|
      "
    )
    end
  end

  describe "#update_player" do

    it "returns the current player @positions list if slot is full" do
      game.board = {
        "a6" => "_", "b6" => "_", "c6" => "0", "d6" => "_", "e6" => "_", "f6" => "_", "g6" => "_",
        "a5" => "_", "b5" => "_", "c5" => "O", "d5" => "_", "e5" => "_", "f5" => "_", "g5" => "_",
        "a4" => "_", "b4" => "_", "c4" => "O", "d4" => "0", "e4" => "_", "f4" => "_", "g4" => "_",
        "a3" => "_", "b3" => "_", "c3" => "0", "d3" => "O", "e3" => "_", "f3" => "_", "g3" => "O",
        "a2" => "_", "b2" => "O", "c2" => "0", "d2" => "0", "e2" => "_", "f2" => "_", "g2" => "0",
        "a1" => "0", "b1" => "O", "c1" => "O", "d1" => "O", "e1" => "0", "f1" => "_", "g1" => "0",
      }

      player1.positions = []
      expect(game.update_player(player1, 'c')).to eql([])
    end

    it "returns the position from the player's selection" do
      player1.positions = []
      expect(game.update_player(player1, 'd')).to eql(["d5"])
    end
  end

  describe "#check_if_tie" do

    it "returns false if not all positions on @board are filled" do
      puts game.board
      expect(game.check_if_tie(game.board)).to eql(false)
    end

    it "returns true if all positions on @board are filled" do
      game.board = {
        "a6" => "0", "b6" => "O", "c6" => "0", "d6" => "0", "e6" => "O", "f6" => "0", "g6" => "O",
        "a5" => "0", "b5" => "O", "c5" => "O", "d5" => "0", "e5" => "O", "f5" => "0", "g5" => "O",
        "a4" => "0", "b4" => "O", "c4" => "O", "d4" => "0", "e4" => "O", "f4" => "0", "g4" => "O",
        "a3" => "0", "b3" => "O", "c3" => "0", "d3" => "0", "e3" => "O", "f3" => "0", "g3" => "O",
        "a2" => "0", "b2" => "O", "c2" => "0", "d2" => "0", "e2" => "O", "f2" => "0", "g2" => "O",
        "a1" => "0", "b1" => "O", "c1" => "O", "d1" => "0", "e1" => "O", "f1" => "0", "g1" => "O",
      }

      expect(game.check_if_tie(game.board)).to eql(true)
    end
  end
end
