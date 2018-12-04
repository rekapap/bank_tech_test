# StatementPrinter
class StatementPrinter
  HEADER = '   date    ||  credit ||  debit || balance'.freeze

  def self.print(transactionlog)
    HEADER
  end
end
