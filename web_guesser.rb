require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
@@guesses = 6
get '/' do
  guess = params["guess"].to_i
  result = check_guess(guess)
  message = result[0]
  end_msg = ""
  color = result[1]
  if @@guesses == 0 || message == "You got it right!"
    end_msg = "The SECRET NUMBER is #{SECRET_NUMBER}"
    @@guesses = 5
    SECRET_NUMBER = rand(101)
  end
  erb :index, :locals => {:number => SECRET_NUMBER, 
    :message => message, :end_msg => end_msg, 
    :color => color, :guesses => @@guesses}
end

def check_guess(guess)
    @@guesses-= 1
    if guess.nil?
        return ["Please enter a guess", "blue"]
    elsif guess < SECRET_NUMBER-5 
        return ["Way too low!", "red"]
    elsif guess >= SECRET_NUMBER-5 && guess < SECRET_NUMBER
        return ["Too low!", "pink"]
    elsif guess == SECRET_NUMBER
        return ["You got it right!", "green"]
    elsif guess >= SECRET_NUMBER+1 && guess <= SECRET_NUMBER+5
        return ["Too high!", "pink"]
    else
        return ["Way too high!", "red"]
    end
end