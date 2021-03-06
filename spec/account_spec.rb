require 'account'
require 'transaction_log'

describe Account do
  let(:array) { double :array }
  let(:transactionlog) { double :transactionlog, add: array }
  let(:transactionlog_class) do
    double :transactionlog_class, new: transactionlog
  end
  subject { described_class.new(transactionlog_class: transactionlog_class) }

  describe '#balance' do
    it 'has zero as an initial balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#deposit' do
    it 'adds money with the date to the balance' do
      expect { subject.deposit(amount: AMOUNT, date: DATE) }.to change {
        subject.balance
      }.from(0).to(AMOUNT)
    end

    it 'can add money to the balance multiple times' do
      subject.deposit(amount: AMOUNT, date: DATE)
      expect { subject.deposit(amount: AMOUNT, date: DATE) }.to change {
        subject.balance
      }.from(AMOUNT).to(AMOUNT + AMOUNT)
    end

    it 'add the amount, date and balance to the the transactionlog' do
      expect(transactionlog).to receive(:add).with(amount: AMOUNT, date: DATE, balance: AMOUNT)
      subject.deposit(amount: AMOUNT, date: DATE)
    end

    it 'raises error if amount is zero' do
      expect do
        subject.deposit(amount: ZERO, date: DATE)
      end.to(raise_error { Account::ZERO_AMOUNT })
    end
  end

  describe '#withdraw' do
    it 'withdraw money from the balance with date' do
      subject.deposit(amount: AMOUNT, date: DATE)
      expect { subject.withdraw(amount: AMOUNT, date: DATE) }.to change {
        subject.balance
      }.from(AMOUNT).to(0)
    end

    it 'can\'t do overdraft' do
      subject.deposit(amount: AMOUNT, date: DATE)
      expect do
        subject.withdraw(amount: 2 * AMOUNT, date: DATE)
      end.to(raise_error { Account::INSUFFICIENT_BALANCE })
    end

    it 'add the negative amount, date, balance to the the transactionlog' do
      subject.deposit(amount: AMOUNT, date: DATE)
      expect(transactionlog).to receive(:add).with(amount: -AMOUNT, date: DATE, balance: ZERO)
      subject.withdraw(amount: AMOUNT, date: DATE)
    end

    it 'raises error if amount is zero' do
      subject.deposit(amount: AMOUNT, date: DATE)
      expect do
        subject.withdraw(amount: ZERO, date: DATE)
      end.to(raise_error { Account::ZERO_AMOUNT })
    end
  end

  describe '#log' do
    it 'returns the transaction log' do
      expect(subject.log).to be_a(transactionlog.class)
    end
  end
end
