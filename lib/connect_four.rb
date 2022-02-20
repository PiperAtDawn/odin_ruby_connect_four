# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'position'

class ConnectFour
  def initialize
    @board = Board.new
    @players = [Player.new, Player.new]
    @game_over = false
    @last_position = nil
    @round = 1
  end

  def play
    play_round until @game_over
    display_board
    congradulate
  end

  private

  def play_round
    display_board
    place_token
    check_for_winner
    @players.rotate! unless @game_over
    @round += 1
  end

  def display_board
    @board.display
  end

  def place_token
    loop do
      col = request_column
      pos = @board.drop_at_col(col, active_token)
      if pos
        @last_position = pos
        break
      end
    end
  end

  def request_column
    loop do
      puts "#{active_player}, choose a column to place your token."
      col = gets.chomp
      return col.to_i if verify_column(col)
    end
  end

  def verify_column(col)
    raise 'Invalid input (must be a number)' unless (Integer(col) rescue false)

    col = col.to_i
    raise "Invalid column value (must be between 0 and #{@board.max_col})" unless col.between?(0, @board.max_col)

    true
  rescue => e
    puts e.message
    false
  end

  def tie?
    @round >= 42
  end

  def check_for_winner
    @game_over = tie? ||
      check_horizontal ||
      check_vertical ||
      check_diagonal_left ||
      check_diagonal_right
  end

  def check_horizontal
    tokens_in_a_line(%i[left right]) >= 4
  end

  def check_vertical
    tokens_in_a_line(%i[up down]) >= 4
  end

  def check_diagonal_left
    tokens_in_a_line(%i[up_left down_right]) >= 4
  end

  def check_diagonal_right
    tokens_in_a_line(%i[up_right down_left]) >= 4
  end

  def tokens_in_a_line(directions)
    tokens = 1
    directions.each do |dir|
      pos = @last_position
      loop do
        pos = pos.send(dir)
        break unless @board.valid_position?(pos) && @board[pos] == active_token

        tokens += 1
      end
    end
    tokens
  end

  def active_token
    @players[0].token
  end

  def active_player
    @players[0].name
  end

  def congradulate
    puts tie? ? "It's a tie!" : "Congradulations, #{active_player}, you won!"
  end
end
