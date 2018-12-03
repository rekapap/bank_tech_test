require_relative '../spec_helper'
require 'account'
require 'statementprinter'

feature 'Bank statement' do
  context 'after deposits and withdrawals' do
    scenario 'user can see his balance, withdrawals and deposits with date' do
      bank_statement = 'date       || credit  || debit  || balance' \
      '14/01/2012 ||         || 500.00 || 2500.00' \
      '13/01/2012 || 2000.00 ||        || 3000.00' \
      '10/01/2012 || 1000.00 ||        || 1000.00'
      account = Account.new
      account.deposit(amount: 1000, date: '10-01-2012')
      account.deposit(amount: 2000, date: '13-01-2012')
      account.withdraw(amount: 500, date: '14-01-2012')
      expect(StatementPrinter.print(account.log)).to eq(bank_statement)
    end
  end
end
