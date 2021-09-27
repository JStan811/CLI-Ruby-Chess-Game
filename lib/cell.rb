# frozen_string_literal: true

# represents single cell on a chess board
class Cell
  def initialize(position, contents = nil)
    @position = position
    @contents = contents
  end

  attr_reader :position, :contents
end
