# Bank Account
class Account
  def initialize
    @balance = 0
  end

  def balance
    @balance.dup
  end

  def deposit(amount:)
    @balance += amount
  end
end
