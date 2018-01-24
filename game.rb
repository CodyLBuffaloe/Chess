require_relative "Cell"
module Chess
  class Board
    attr_accessor :board
    def initialize(input = {})
      @board = input.fetch(:board, default_board)
    end
    def starting_positions
      (0...8).each do |p|
        @board[1][p].value = Piece.new(:white, :pawn).figure
        @board[6][p].value = Piece.new(:black, :pawn).figure
      end
      @board[0][4].value = Piece.new(:white, :king).figure
      @board[7][4].value = Piece.new(:black, :king).figure

      @board[0][3].value = Piece.new(:white, :queen).figure
      @board[7][3].value = Piece.new(:black, :queen).figure

      @board[0][2].value = Piece.new(:white, :bishop).figure
      @board[0][5].value = Piece.new(:white, :bishop).figure
      @board[7][2].value = Piece.new(:black, :bishop).figure
      @board[7][5].value = Piece.new(:black, :bishop).figure

      @board[0][1].value = Piece.new(:white, :knight).figure
      @board[0][6].value = Piece.new(:white, :knight).figure
      @board[7][1].value = Piece.new(:black, :knight).figure
      @board[7][6].value = Piece.new(:black, :knight).figure

      @board[0][0].value = Piece.new(:white, :rook).figure
      @board[0][7].value = Piece.new(:white, :rook).figure
      @board[7][0].value = Piece.new(:black, :rook).figure
      @board[7][7].value = Piece.new(:black, :rook).figure
    end
    def display_formatted_board
      @board.each do |rank|
        puts rank.map{|cell| cell.value}.join(" ")
      end
    end
    def default_board
      Array.new(8) {Array.new(8) {Cell.new} }
    end
  end
   #Rank: horizontal line
    #File: vertical line
  class Piece #Stores the Unicode values of the pieces
  attr_accessor :figure
    def initialize (color, piece)
      if color == :black
        if piece == :pawn
          @figure = "\u{265F}".encode('utf-8')
        end
        if piece == :king
          @figure == "\u{265A}".encode('utf-8')
        end
        if piece == :queen
          @figure = "\u{265B}".encode('utf-8')
        end
        if piece == :knight
          @figure = "\u{265E}".encode('utf-8')
        end
        if piece == :bishop
          @figure = "\u{265D}".encode('utf-8')
        end
        if piece == :rook
          @figure = "\u{265C}".encode('utf-8')
        end
      elsif color == :white
        if piece == :pawn
          @figure = "\u{2659}".encode('utf-8')
        end
        if piece == :king
          @figure = "\u{2654}".encode('utf-8')
        end
        if piece == :queen
          @figure = "\u{2654}".encode('utf-8')
        end
        if piece == :knight
          @figure = "\u{2658}".encode('utf-8')
        end
        if piece == :bishop
          @figure = "\u{2657}".encode('utf-8')
        end
        if piece == :rook
          @figure = "\u{2656}".encode('utf-8')
        end
      end
    end
  end

  class Moves
    #And this will probably be where I write specific methods for each piece, like #Knight_Moves or #Queen_Moves
    #Since they will have multiple difference scenarios.

    #King
    #Move one square in any direction 
    #Special Move: Castling, needs Rook to complete
                                                          #]------> Castling:
                                                                    #Once a game, once per King
                                                                    #Can only do if you haven't previously moved your rook or king
                                                                    #King must have a clear path, no other pieces can be on the line
                                                                    #Cannot use this move once in Check
                                                                    #King cannot pass through squares occupied by opposing pieces
                                                                    #Can't put himself in Check
                                                                    #Rook can be "in Check" or take pieces in it's way

     #Rook
      #Cannot leap over other pieces (Castles can't jump duh)
     #Moves any number of squares in a straight line
     #Needed for Castling, which is a move of the King

      #Bishop
      #Moves diagonally any number of squares
      #Cannot leap over pieces (Holy men can't make enemies of their potential converts)

      #Queen
      #Has the movesets and limitations of the Rook and Bishop
      #IOW: Moves straight and diagonal but can't jump pieces

       #Knight
        #ONLY PIECE THAT CAN LEAP OVER OTHER PIECES
        #Moves only 3 squares at a time, two vertical and one horizontal or two horizontal and one vertical
        #Can also do this move diagonally, two diagonal and one vertical or horizontal from that

         #Pawn
          #Moves forward one square
         #IF this is the first move for the pawn, it can move two squares forward provided they are not occupied
         #Can capture an opponents piece if that piece is one square diagonally in front of the pawn (Pawn moves to occupy the space)
         #Special Moves: En Passant Capture, Promotion
       #En Passant Capture:
       #If your opponent uses their pawn to move two squares, and ends up next to your pawn, you can capture their pawn with your pawn on your very next move
       #Your pawn then takes the square they jumped to get to where you captured them
       #Promotion:
       #If a pawn makes it all the way across the board, you can exchange it for a better piece (usually a queen) that had previously been captured
       #The only restrictions on asking for pieces are no more pawns (wouldn't be a promotion anyway) and no Kings. Bishops, Rooks, Knights, and Queens are all good, with queens being the most valuable and strategicaly useful.
  end

  class Game
    attr_accessor :p1, :p2, :board
    def initialize(players)
      @players = players
      @p1 = players[0]
      @p2 = players[1]
      @board = Board.new()
    end
    def play
      board.starting_positions
      board.display_formatted_board
    end
  end
       #This is where the game logic will be, how it starts and how it ends.
       #So my method announcing check and checkmate will probably be here
       #Check: when a player is under immediate attack (the next immediate move puts them in capture)
       #Win is when a player has no valid moves left to escape check
       #Resignation option? Don't want people to be forced to play in a hopeless position

  class Player
    attr_accessor :name, :color, :piece_set
    def initialize(name, color)
      @name = name
      @color = color
    end
  #I will need to be able to track how many pieces each player has, and whether or not they lost? I guess the losing part
  #will be taken care of by the Game class.
  end

  #Rules
  #White moves first, so whoever chooses white is Player1
end
p1 = Chess::Player.new("Cody", :white)
p2 = Chess::Player.new("Bootyboy", :black)
players = [p1, p2]
game = Chess:: Game.new(players)
game.play
