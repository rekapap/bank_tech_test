require 'statement_printer'

describe StatementPrinter do
  describe '.print' do
    context 'empty recorde' do
      let(:transactionlog_empty) { double :transactionlog, data: [] }
      it 'returns the header if there is no record in the log' do
        expect(described_class.print(transactionlog_empty)).to eq('   date    ||  credit ||  debit || balance')
      end

      it 'calls the data method on transactionlog' do
        expect(transactionlog_empty).to receive(:data)
        described_class.print(transactionlog_empty)
      end
    end

    context 'not empty record' do
      context 'desposit records only' do
        let(:bank_statement) do
          "   date    ||  credit ||  debit || balance\n" \
          '01/01/2018 || 1000.00 ||        ||'
        end
        let(:array) { [{ amount: AMOUNT, date: Date.parse(DATE) }] }
        let(:transactionlog) { double :transactionlog, data: array }
        it 'can print out the date and the debit' do
          expect(described_class.print(transactionlog)).to eq(bank_statement)
        end
      end
    end
  end
end
