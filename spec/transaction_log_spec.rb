require 'transaction_log'

describe TransactionLog do
  subject { described_class.new }

  describe '#add' do
    it 'adds a new recod to the log' do
      subject.add(amount: AMOUNT)
      expect(subject.data).to include(amount: AMOUNT)
    end
  end

  describe '#data' do
    it 'returns the list of records of the log, initially empty' do
      expect(subject.data).to be_a(Array)
    end
  end
end
