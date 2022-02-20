# frozen_string_literal: true

class Position
  attr_reader :array, :row, :col

  def initialize(row, col)
    @row = row
    @col = col
    @array = [row, col]
  end

  def up
    Position.new(row + 1, col)
  end

  def down
    Position.new(row - 1, col)
  end

  def left
    Position.new(row, col - 1)
  end

  def right
    Position.new(row, col + 1)
  end

  def up_left
    Position.new(row + 1, col - 1)
  end

  def up_right
    Position.new(row + 1, col + 1)
  end

  def down_left
    Position.new(row - 1, col - 1)
  end

  def down_right
    Position.new(row - 1, col + 1)
  end
end