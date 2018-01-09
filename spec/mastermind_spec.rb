#spec/mastermind_spec.rb
require 'mastermind'

describe ComputerPlayer do
  describe '.generate_code' do
    subject do
      ComputerPlayer.new
    end
    context 'when called' do
      it 'generates a 4 letter code using any of A-F' do
        expect(subject.generate_code).to match(/[A-F]{4}/)
      end
    end
  end
end

describe HumanPlayer do
  subject do
    HumanPlayer.new
  end
  describe '.check_input' do
    context 'when input is not 4 characters' do
      it 'returns error code' do
        expect(subject.check_input('')).to eql('Code must contain four characters.')
        expect(subject.check_input('AC')).to eql('Code must contain four characters.')
        expect(subject.check_input('ABCDEF')).to eql('Code must contain four characters.')
      end
    end
    context 'when input contains characters besides A-F' do
      it 'returns error code' do
        expect(subject.check_input('A2BE')).to eql('Code may only contain letters A through F.')
        expect(subject.check_input('!DFE')).to eql('Code may only contain letters A through F.')
        expect(subject.check_input('AZRC')).to eql('Code may only contain letters A through F.')
      end
    end
    context 'when input is 4 characters chosen from A-F' do
      it 'returns valid code' do
        expect(subject.check_input('ACFE')).to eql('ACFE')
      end
    end
  end
end

describe Round do
  subject do
    Round.new
  end

  describe '.compare_code' do
    context 'given a guess which completely matches the code' do
      it 'returns 4 correct, 0 partially correct' do
        subject.code = 'FBEC'
        expect(subject.compare_code('FBEC')).to eql([4, 0])
        subject.code = 'ADFC'
        expect(subject.compare_code('ADFC')).to eql([4, 0])
        subject.code = 'AABB'
        expect(subject.compare_code('AABB')).to eql([4, 0])
      end
    end
    context 'given a guess which partially matches the code' do
      it 'returns # correct, and # partially correct' do
        subject.code = 'ABBA'
        expect(subject.compare_code('AAAA')).to eql([2, 0])
        expect(subject.compare_code('AABB')).to eql([2, 2])
        expect(subject.compare_code('ABAB')).to eql([2, 2])
        expect(subject.compare_code('BABA')).to eql([2, 2])
        subject.code = 'CFBE'
        expect(subject.compare_code('FBEC')).to eql([0, 4])
        expect(subject.compare_code('CCFF')).to eql([1, 1])
        subject.code = 'ADCF'
        expect(subject.compare_code('ADFC')).to eql([2, 2])
        expect(subject.compare_code('ADDC')).to eql([2, 1])
        subject.code = 'EEFA'
        expect(subject.compare_code('ADFC')).to eql([1, 1])
        expect(subject.compare_code('EEEF')).to eql([2, 1])
      end
    end
    context 'given a guess which does not match at all' do
      it 'returns 0 correct' do
        subject.code = 'ABBC'
        expect(subject.compare_code('DDEF')).to eql([0, 0])
      end
    end
  end

end
