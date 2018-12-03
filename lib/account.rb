# Bank Account
class Account
  INSUFFICIENT_BALANCE = 'No sufficient balance available'.freeze

  def initialize
    @balance = 0
  end

  def balance
    @balance.dup
  end

  def deposit(amount:)
    @balance += amount
  end

  def withdraw(amount:)
    raise INSUFFICIENT_BALANCE if amount > @balance

    @balance -= amount
  end
end
