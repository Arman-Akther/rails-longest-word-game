require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times do
      letter = alphabet.sample
      @letters.push(letter)
    end
  end

  def score
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    response = JSON.parse(url)
    # if word in api & letters are in array then congrats
    # elsif letters in array [not word in api] = sry not valid
    # else = cannot be built
    letters_word = params[:word].split("")
    @letters_array = params[:letters].split("")
    letters_match = letters_word.all? do |letter|
      @letters_array.include?(letter)
    end


    if response["found"] && letters_match
      @results = "congrats #{params[:word]} is a valid word"
    elsif letters_match
      @results = "Sry your illterate bafoon #{params[:word]} is not a word"
    else
      @results = "Can you read? #{params[:word]} Wasn't even the correct letters"
    end
    # @result = params[:result]

    # score = 0
    # case result
    # when correct then score += 1
    # when wrong then score = score
    # when incorrect then score -= 1
    # end
  end

end
