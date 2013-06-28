# encoding: utf-8


require_relative 'piece'
require_relative 'board'
require 'colored'

class Game
  
  attr_accessor :board_object
  
  def initialize
    @board_object = Board.new
  end
  
  def play
    player = :red
    
    while @board_object.count(player) != 0
      begin
        puts @board_object
        puts "#{player} player's turn."
        move_sequence = gets.split(", ")
#REV: You should check to see if the input is valid. If it's not, the player
#     whose turn it is should be reprompted. Upon testing, the program moved on
#     to the other player.        
        move_sequence.map!{|position| position.to_i}
        @board_object.perform_moves(move_sequence)
      rescue InvalidMoveError
#REV: Consider doing what we did in chess yesterday. rescue StandardError and pass in
#     specific prompts to enhance the interface. ex: Invalid, moved off board.
        puts "That wasn't a valid move. :( You lose your turn!"
      end
      player = player == :red ? :white : :red
    end
    
    puts "#{player} loses. :("
    player = player == :red ? :white : :red
    puts "#{player} wins! Yay! :)"
  
  end
  
end

g = Game.new
g.play