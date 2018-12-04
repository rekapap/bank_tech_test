require 'transaction_log'

describe TransactionLog do
  subject { described_class.new }

  describe '#add' do
    it 'adds a new hash recod to the log' do
      subject.add(amount: AMOUNT, date: DATE)
      expect(subject.data.first).to be_a(Hash)
    end

    it 'adds the amount to the log' do
      subject.add(amount: AMOUNT, date: DATE)
      expect(subject.data.first[:amount]).to eq(AMOUNT)
    end

    it 'adds the date to the log' do
      subject.add(amount: AMOUNT, date: DATE)
      expect(subject.data.first[:date]).to eq(DATE)
    end
  end

  describe '#data' do
    it 'returns the list of records of the log, initially empty' do
      expect(subject.data).to be_a(Array)
    end
  end
end
