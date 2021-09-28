# frozen_string_literal: true

# represents single cell on a chess board
class Cell
  def initialize
    @cell_contents = nil
  end

  attr_accessor :cell_contents
end
