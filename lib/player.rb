# frozen_string_literal: true

class Player
  attr_reader :name, :token

  @@count = 0

  def initialize(name: "Player #{@@count + 1}", token: (@@count + 1).to_s)
    @name = name
    @token = token
    @@count += 1
  end
end