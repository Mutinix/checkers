# encoding: utf-8


require_relative 'Piece'
require 'colored'

class Board

  attr_accessor :pieces
  
  def initialize
    @pieces = init_pieces
  end

  def init_pieces
    pieces = []
    12.times {pieces.insert(0, RedPiece.new)}
    12.times {pieces.insert(20, WhitePiece.new)}
    pieces
  end

  def count(colour)
    colour == :red ? red_count : white_count
  end
  
  def red_count
    @pieces.count {|piece| !piece.nil? and piece.colour == :red}
  end
  
  def white_count
    @pieces.count {|piece| !piece.nil? and piece.colour == :white}
  end
  
  def to_s
    
    spaces = [" "] * 4
    row = piece_squares[row_index * 4, 4]
    
    output_board = ""
    
    8.times do |row_index|
      if row_index.even?
        puts "It's even!"
        first = spaces
        second = @pieces
      else
        puts "It's odd!"
        first = @pieces
        second = spaces
      end
      
      4.times do |col_index|
        output_board += first[col_index].to_s + second[col_index].to_s
      end
      output_board += "\n"
    end
    output_board
  end

end