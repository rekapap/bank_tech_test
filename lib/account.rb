require_relative 'transaction_log.rb'
# Bank Account
class Account
  INSUFFICIENT_BALANCE = 'No sufficient balance available'.freeze

  def initialize(transactionlog_class: TransactionLog)
    @balance = 0
    @log = transactionlog_class.new
  end

  def balance
    @balance.dup
  end

  def deposit(amount:, date:)
    @balance += amount
    @log.add(amount: amount, date: date)
  end

  def withdraw(amount:, date:)
    raise INSUFFICIENT_BALANCE if amount > @balance

    @balance -= amount
    @log.add(amount: -amount, date: date)
  end

  def log
    @log.dup
  end
end
