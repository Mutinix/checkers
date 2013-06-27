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
    
    output_board = ["\n"]
    
    8.times do |row_index|
      row = @pieces[row_index * 4, 4]
      
      if row_index.even?
        first = spaces
        second = row
      else
        first = row
        second = spaces
      end
      
      4.times do |col_index|
        output_board << first[col_index]
        output_board << second[col_index]
      end
      output_board << "\n"
    end
    output_board.map!{|ch| ch == "" ? " " : ch}
    output_board.join(" ")
  end

  
  def move(from, to)
    execute_move(from, to) if @pieces[from - 1].valid_move?(from, to)
  end
  
  def execute_move(from, to)
    piece = @pieces[from - 1]
    @pieces[from - 1] = nil
    @pieces[to - 1] = piece
  end


end