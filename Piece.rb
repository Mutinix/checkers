# encoding: utf-8

require 'colored'

class Piece
#REV: What's colour? :)
  attr_reader :colour
  
  def king?
    false
  end
  
  def position_to_row(position)
    row = (position / 4.0).ceil
  end
  
  def to_s
    " "
  end
  
  def crown
    KingPiece.new(@colour)
  end

end

#REV: Interesting implementation. You could probably refactor this into a single
#     piece class. In doing so, piece could contain generic methods that take in
#     a symbol to represent color and the pieces location. In fact, I even passed
#     in a piece type, so my entire piece class was less than 40 lines.
class RedPiece < Piece

  def initialize
    @colour = :red
  end
  
  def to_s
    " \u25CF ".red_on_black
  end

#REV: Try to make an effort to make variables passed in clear in their name.
#     Instead of From / To, starting_location / final_location
#     I did this part quite differently anyway, using (row + space) % 2 == 1  
  def valid_move?(from, to)
    row = position_to_row(from)

    return if row + 1 != position_to_row(to)

    if row.even?
      [from + 3, from + 4].include? to
    else
      [from + 4, from + 5].include? to
    end
  end
  
  def valid_jump?(from, to)
   row = position_to_row(from)
   return if row + 2 != position_to_row(to)

   case to
   when from + 7
     row.even? ? from + 3 : from + 4
   when from + 9
     row.even? ? from + 4 : from + 5
   else
     nil
   end
  end

#REV: If symbols were used, these methods can be combined with if  ?  :
  def crowned?(piece_location)
    position_to_row(piece_location) == 8
  end

end


class WhitePiece < Piece
  
  def initialize
    @colour = :white
  end
  
  def to_s
    " \u25CF ".white_on_black
  end
  
  def valid_move?(from, to)
    row = position_to_row(from)
    return if row - 1 != position_to_row(to)

    if row.even?
      [from - 4, from - 5].include?(to)
    else
      [from - 3, from - 4].include?(to)
    end
  end
  
  def valid_jump?(from, to)
   row = position_to_row(from)
   return if row - 2 != position_to_row(to)

   case to
   when from - 7
     row.even? ? from - 4 : from - 3
   when from - 9
     row.even? ? from - 5 : from - 4
   else
     nil
   end
  end
  
  def crowned?(piece_location)
    position_to_row(piece_location) == 1
  end
 
end

class KingPiece < Piece 
  
  def initialize(colour)
    @colour = colour
    @white_piece = WhitePiece.new
    @red_piece = RedPiece.new
  end
  
  def to_s
    @colour == :white ? " \u25CE ".white_on_black : " \u25CE ".red_on_black
  end
  
  def valid_move?(from, to)
    @white_piece.valid_move?(from, to) || @red_piece.valid_move?(from, to)
  end
  
  def valid_jump?(from, to)
    @white_piece.valid_jump?(from, to) || @red_piece.valid_jump?(from, to)
  end
  
  
end