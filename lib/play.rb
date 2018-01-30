#lib/play.rb
require_relative 'mastermind'

puts "Welcome to Mastermind."
human_role = ''
loop do
  puts "Please enter '1' if you would like to be codemaker, or 2 if you would like to be codebreaker."
  human_role = gets.chomp
  if human_role.match(/[12]/)
    break
  else
    puts "Invalid input."
  end
end

current_round = Round.new
current_round.play_round(human_role)
