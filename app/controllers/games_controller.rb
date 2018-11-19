# frozen_string_literal: true

require 'open-uri'
require 'json'

# this class checks game input
class GamesController < ApplicationController
  LETTER_ARRAY = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].freeze

  def new
    @letters = []
    10.times { @letters << LETTER_ARRAY.sample }
    @letters
  end

  def grid_checker?(attempt, grid)
    @attempt_array = attempt.upcase.split('')
    @grid_array = grid.upcase.split('')
    @attempt_array.each do |letter|
      if @grid_array.include?(letter)
        @grid_array.delete_at(@grid_array.index(letter))
      else
        false
      end
    end
    true
  end

  def json_to_hash(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    JSON.parse(open(url).read)
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    attempt_result = json_to_hash(@word)
    if grid_checker?(@word, @grid) == false
      @score = 0
    elsif attempt_result['found'] == false
      @score = 1
    end
  end
end
