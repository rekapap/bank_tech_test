# Transaction Log class
class TransactionLog
  def initialize
    @data = []
  end

  def add(amount:, date:)
    @data << { amount: amount, date: date }
  end

  def data
    @data.dup
  end
end
