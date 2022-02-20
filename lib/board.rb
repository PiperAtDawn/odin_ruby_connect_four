# frozen_string_literal: true

require_relative 'position'

class Board
  attr_reader :max_row, :max_col, :empty_symbol

  def initialize(width: 7, height: 6, empty_symbol: '-')
    @board = Array.new(height) { Array.new(width, empty_symbol) }
    @max_row = height - 1
    @max_col = width - 1
    @empty_symbol = empty_symbol
  end

  def display
    puts '-----------------------------'
    @board.reverse.each do |row|
      puts "| #{row.join(' | ')} |"
    end
    puts '-----------------------------'
    puts "| #{[*0..max_col].join(' | ')} |"
  end

  def [](pos)
    @board[pos.row][pos.col]
  end

  def valid_position?(pos)
    pos.row.between?(0, max_row) && pos.col.between?(0, max_col)
  end

  def drop_at_col(col, value)
    @board.each_with_index do |row, row_index|
      if row[col] == @empty_symbol
        row[col] = value
        return Position.new(row_index, col)
      end
    end
    puts 'No empty square in this column!'
    false
  end
end
