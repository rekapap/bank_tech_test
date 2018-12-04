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
  end
end
