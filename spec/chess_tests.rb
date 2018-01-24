require "./game.rb"

  describe "#Board" do
    describe ".default_board" do
      context "new board created" do
        it "created an 8x8 board" do
          b = Chess::Board.new
          expect(b.board.size).to eql(8)
        end
      end
    end
  end

  describe "#Player" do
    describe ".initialize" do
      context "new player created" do
        it "records name and color of player" do
          p = Chess::Player.new("Cody", :white)
          expect(p.name).to eql("Cody")
        end
      end
    end
  end