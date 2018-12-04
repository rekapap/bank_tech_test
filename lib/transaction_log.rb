# Transaction Log class
class TransactionLog
  def initialize
    @data = []
  end

  def add(amount:)
    @data << { amount: amount }
  end

  def data
    @data.dup
  end
end
