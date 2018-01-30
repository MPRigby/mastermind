#lib/mastermind.rb
class ComputerPlayer
  def generate_code
    (0..3).map { rand(65..70).chr }.join
  end

  def guess_code
    (0..3).map { rand(65..70).chr }.join
  end
end

class HumanPlayer
  def get_input
    loop do
      input = gets.chomp
      input.upcase!
      checked_input = check_input(input)
      if checked_input.length != 4
        puts checked_input #puts error description if user input is invalid
      else
        return checked_input
      end
    end
  end

  def check_input(input)
    if input.length != 4
      return 'Code must contain four characters.'
    end
    if input.match(/[^A-F]/)
      return 'Code may only contain letters A through F.'
    end
    return input
  end
end

class Round
  attr_accessor :code

  def initialize
    @player = HumanPlayer.new
    @npc = ComputerPlayer.new
  end

  def compare_code(guess)
    code_temp = @code.dup
    guess_temp = guess.dup
    #check for complete matches and remove from guess and code
    letter_and_position_correct = 0
    i=0
    guess_temp.each_char do |g|
      if g == code_temp[i]
        letter_and_position_correct += 1
        guess_temp.slice!(i)
        code_temp.slice!(i)
        i -= 1
      end
      i+=1
    end
    #check remaining characters for partial matches
    position_only_correct = 0
    guess_temp.each_char do |g|
      if code_temp.include?(g)
        position_only_correct += 1
        code_temp.sub!(g, '')
      end
    end
    [letter_and_position_correct, position_only_correct]
  end

  def play_round(human_role)
    if human_role == '1'
      human_codemaker
    else
      computer_codemaker
    end
  end

  def computer_codemaker
    @code = @npc.generate_code
    i=1
    winner = 'Computer'
    puts "Computer has set a 4 letter code using letters A-F.  Repeat letters are possible. You have 12 attempts to guess the code."
    12.times do
      guess = ''
      plurals = ['s', 's']
      puts "Input code guess #{i}:"
      guess = @player.get_input
      result = compare_code(guess)
      if result == [4, 0]
        puts "The code is cracked!"
        winner = 'Player'
        break
      else
        2.times do |i|
          result[i] == 1 ? plurals[i] = ' is' : plurals[i] = 's are'
        end
        puts "Guess #{i}: #{guess}\n#{result[0]} character#{plurals[0]} the right letter in the right position.  #{result[1]} character#{plurals[1]} the right letter but in the wrong position."
      end
      i += 1
    end
    puts "#{winner} wins!"
  end

  def human_codemaker
    puts "Please input a 4 letter code using letters A-F.  Repeat letters are possible."
    @code = @player.get_input
    winner = "Computer failed to guess code.\nPlayer"
    i = 1
    12.times do
      guess = @npc.guess_code()
      puts "Guess #{i}: #{guess}"
      result = compare_code(guess)
      if result == [4, 0]
        puts "The code is cracked!"
        winner = 'Computer'
        break
      end
      i+=1
    end
    puts "#{winner} wins!"
  end
end

def play_full_game
end
