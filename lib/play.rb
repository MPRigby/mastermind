#lib/play.rb
require_relative 'mastermind'

puts "Welcome to Mastermind."
current_round = Round.new
current_round.play_round


=begin
loop do
  play_game
  puts "Type 'Y' to play again, or any other key to exit."
  input = gets.chomp
  if input[/[^Yy]/]
    break
  end
end
=end
