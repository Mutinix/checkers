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
    " "git
  end

end


class RedPiece < Piece

  def initialize
    @colour = :red
  end
  
  def to_s
    "R"
  end

end


class WhitePiece < Piece
  
  def initialize
    @colour = :white
  end
  
  def to_s
    "W"
  end
  
end