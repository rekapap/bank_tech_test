require 'account'

describe Account do
  subject { described_class.new }
  before(:all) do
    AMOUNT = 1000
  end

  describe '#balance' do
    it 'has zero as an initial balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#deposit' do
    it 'adds money to the balance' do
      expect { subject.deposit(amount: AMOUNT) }.to change {
        subject.balance
      }.from(0).to(AMOUNT)
    end

    it 'can add money to the balance multiple times' do
      subject.deposit(amount: AMOUNT)
      expect { subject.deposit(amount: AMOUNT) }.to change {
        subject.balance
      }.from(AMOUNT).to(AMOUNT + AMOUNT)
    end
  end

  describe '#withdraw' do
    it 'withdraw money from the balance' do
      subject.deposit(amount: AMOUNT)
      expect { subject.withdraw(amount: AMOUNT) }.to change {
        subject.balance
      }.from(AMOUNT).to(0)
    end
  end
end
