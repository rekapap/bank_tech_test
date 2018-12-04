require_relative 'transaction_log.rb'
# Bank Account
class Account
  INSUFFICIENT_BALANCE = 'No sufficient balance available'.freeze
  ZERO_AMOUNT = "Can't do transactions with zero".freeze

  def initialize(transactionlog_class: TransactionLog)
    @balance = 0
    @log = transactionlog_class.new
  end

  def balance
    @balance.dup
  end

  def deposit(amount:, date:)
    raise ZERO_AMOUNT if amount.zero?

    @balance += amount
    @log.add(amount: amount, date: date, balance: balance)
  end

  def withdraw(amount:, date:)
    raise ZERO_AMOUNT if amount.zero?
    raise INSUFFICIENT_BALANCE if amount > @balance

    @balance -= amount
    @log.add(amount: -amount, date: date, balance: balance)
  end

  def log
    @log.dup
  end
end
