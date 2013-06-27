# encoding: utf-8

require_relative 'piece'
require 'colored'

class InvalidMoveError < StandardError
end

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
    
    spaces = ["   ".white_on_cyan] * 4
    
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
    output_board.map!{|ch| ch = ch.nil? ? "   ".white_on_black : ch}
    output_board.join("".white_on_cyan)
  end

  
  def slide(from, to)
    if !@pieces[from - 1].nil? and @pieces[from - 1].valid_move?(from, to)
      perform_slide(from, to)
    else
      raise InvalidMoveError.new
    end
  end
  
  def jump(from, to)
    if !@pieces[from - 1].nil? and !@pieces[from - 1].valid_jump?(from, to).nil?
      perform_jump(from, to) 
    else
      raise InvalidMoveError.new
    end
  end
  
  def perform_jump(from, to)
    removed_location = @pieces[from - 1].valid_jump?(from, to)
    if removed_location.nil?
      raise InvalidMoveError.new
    else
      piece = @pieces[from - 1]
      @pieces[from - 1] = nil
      @pieces[removed_location - 1] = nil
      @pieces[to - 1] = piece
      @pieces[to - 1] = @pieces[to - 1].crown if @pieces[to - 1].crowned?(to)
    end
  end
  
  def perform_slide(from, to)
    piece = @pieces[from - 1]
    @pieces[from - 1] = nil
    @pieces[to - 1] = piece
    @pieces[to - 1] = @pieces[to - 1].crown if @pieces[to - 1].crowned?(to)
  end
  
  def perform_moves!(move_sequence)
    count = move_sequence.length
    
    from = move_sequence[0]
    to = move_sequence[1]
    
    raise InvalidMoveError.new if @pieces[from - 1].nil?
    
    if count == 2 and @pieces[from - 1].valid_move?(from, to)
      slide(from, to)
      return
    end
    
    (1..count-1).each do |index|
      raise InvalidMoveError.new if @pieces[from - 1].nil?
      jump(from, to)
      from, to = move_sequence[index], move_sequence[index+1]
    end  
  end
  
  def valid_move_seq?(move_sequence)
    begin
      perform_moves!(move_sequence)
    rescue InvalidMoveError.new
      return false
    end
    return true
  end
  
  def perform_moves(move_sequence)
    if self.dup.valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError.new
    end
  end

end