# encoding: utf-8


class Piece

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

end


class RedPiece < Piece

  def initialize
    @colour = :red
  end
  
  def to_s
    "R"
  end
  
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


end


class WhitePiece < Piece
  
  def initialize
    @colour = :white
  end
  
  def to_s
    "W"
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