# StatementPrinter
class StatementPrinter
  HEADER = '   date    ||  credit ||  debit || balance'.freeze

  def self.print(transactionlog)
    return HEADER if transactionlog.data.empty?
  end
end
