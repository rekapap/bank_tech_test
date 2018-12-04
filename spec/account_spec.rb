require 'account'
require 'transaction_log'

describe Account do
  let(:array) { double :array }
  let(:transactionlog) { double :transactionlog, add: array }
  let(:transactionlog_class) do
    double :transactionlog_class, new: transactionlog
  end
  subject { described_class.new(transactionlog_class: transactionlog_class) }
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

    it 'add the amount the the transactionlog' do
      expect(transactionlog).to receive(:add).with(amount: AMOUNT)
      subject.deposit(amount: AMOUNT)
    end
  end

  describe '#withdraw' do
    it 'withdraw money from the balance' do
      subject.deposit(amount: AMOUNT)
      expect { subject.withdraw(amount: AMOUNT) }.to change {
        subject.balance
      }.from(AMOUNT).to(0)
    end

    it 'can\'t do overdraft' do
      subject.deposit(amount: AMOUNT)
      expect do
        subject.withdraw(amount: 2 * AMOUNT)
      end.to(raise_error { Account::INSUFFICIENT_BALANCE })
    end
  end

  describe '#log' do
    it 'returns the transaction log' do
      expect(subject.log).to be_a(transactionlog.class)
    end
  end
end
