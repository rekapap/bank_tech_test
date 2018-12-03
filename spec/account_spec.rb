require 'account'

describe Account do
  subject { described_class.new }

  describe '#balance' do
    it 'has zero as an initial balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#deposit' do
    it 'adds money to the balance' do
      AMOUNT = 1000
      expect { subject.deposit(amount: AMOUNT) }.to change {
        subject.balance
      }.from(0).to(AMOUNT)
    end
  end
end
