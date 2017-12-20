require_relative "Cell"
module Chess
  #There is a point system to use to evaluate the worth of pieces, maybe use that for tracking pieces moving on the board?
  class Board
     #Will be an 8x8 board of alternating black and white squares
     #Can we do black and white?
     #Use the same board builder as all the others only w/unicode characters in place of the typical "_"
     #How will I assign each square a specific nomiker like A7 or G5? That's how people will be moving, right?
     #White corner in the right hand side closest to each player
     #White Queen on white square, black on black
    attr_accessor :board
    def initialize(input = {})
      @board = input.fetch(:board, default_board)
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
  class Piece

     #Will I need different classes for each piece?
     #Each piece should know what it is, so I will need a class for each type of piece so they only know how to move themselves?
     #That way, only pawns know how to move like pawns, and knights like knights?
     #I guess this class should only be for defining the pieces though

    #A Piece
    # - Has a type
    # - How to convey type: a point value system like in real chess? I.E. Queen = 9 Pawn = 1
    #Starting Values:
    #Pawn = 1 (x8)
    #Knight = 3 (x2)
    #Bishop = 3 (x2)
    #Rook = 5 (x2)
    #Queen = 9
    # - Has a name
    # - Has a set of distinct moves shared between all the piece of that type
    # - Has an original place on the board, based on it's type and, in case of the queen, color.
    def initialize(player, status = :active)
      if player.color == :white
        white = { :king => "\u{2654}", :queen => "\u{2655}", :night => "\u{2658}", :bishop => "\u{2657}", :rook => "\u{2656}", :pawn => "\u{2659}" }
        white.each_value do |value|
          puts value
        end
      else
        black = { :king => "\u{265A}", :queen => "\u{265B}", :night => "\u{265E}", :rook => "\u{265C}", :bishop => "\u{265D}", :pawn => "\u{265F}" }
        black.each_value do |value|
          puts value
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
    def display_piece
      Piece.new(p2)
    end
    def play
      board.display_formatted_board
      display_piece()

    end
  end
       #This is where the game logic will be, how it starts and how it ends.
       #So my method announcing check and checkmate will probably be here
       #Check: when a player is under immediate attack (the next immediate move puts them in capture)
       #Win is when a player has no valid moves left to escape check
       #Resignation option? Don't want people to be forced to play in a hopeless position

  class Player
    attr_accessor :name, :color
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
