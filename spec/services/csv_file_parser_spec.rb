require 'rails_helper'

RSpec.describe CsvFileParser do
  subject(:parser) { described_class.new(csv_url) }
  let(:csv_url) { 'my_url.com' }
  let(:csv_string) do
    "ZIP,CBSA\n501,35004\n601,10260\n606,99999"
  end
  let(:rows) do
    [
      Hashie::Mash.new('zip' => '501', 'cbsa' => '35004'),
      Hashie::Mash.new('zip' => '601', 'cbsa' => '10260'),
      Hashie::Mash.new('zip' => '606', 'cbsa' => '99999')
    ]
  end

  describe '#call' do
    context 'Valid link' do
      before do
        expect(subject).to receive(:fetch_csv)
          .and_return(csv_string)
      end

      it 'returns an array of hash rows' do
        expect(subject.call).to match_array(rows)
      end
    end

    context 'Invalid link' do
      before do
        expect(subject).to receive(:fetch_csv).and_raise('Some Error')
      end

      it 'returns an array of hash rows' do
        expect{ subject.call }.to raise_error(RuntimeError, "Could not read the CSV file: Some Error")
      end
    end
  end
end
