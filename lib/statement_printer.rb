# StatementPrinter
class StatementPrinter
  HEADER = '   date    ||  credit ||  debit || balance'.freeze

  def self.print(transactionlog)
    log = transactionlog.data
    return HEADER if log.empty?

    record_log = log.map do |record|
      make_string_record(record)
    end
    HEADER + "\n" + record_log.reverse.join("\n")
  end

  class << self
    private

    def make_string_record(record)
      date = date_format(record[:date])
      transaction = transaction_string(record[:amount])
      balance = amount_format(record[:balance])
      date + ' || ' + transaction + ' || ' + balance
    end

    def transaction_string(amount)
      amount_string = amount_format(amount.abs)
      return amount_string + ' ||       ' if amount > 0

      '        || ' + amount_string
    end

    def amount_format(amount)
      format('%.2f', amount)
    end

    def date_format(date)
      date.strftime('%d/%m/%Y')
    end
  end
end
