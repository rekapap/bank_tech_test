require 'account'

describe Account do
  subject { described_class.new }

  describe '#balance' do
    it 'has zero as an initial balance' do
      expect(subject.balance).to eq(0)
    end
  end
end
