require 'date'
# Transaction Log class
class TransactionLog
  def initialize
    @data = []
  end

  def add(amount:, date:, balance:)
    parsed_date = Date.parse(date)
    @data << { amount: amount, date: parsed_date, balance: balance }
  end

  def data
    @data.dup
  end
end
