require 'rails_helper'

RSpec.describe RetrieveZipData do
  subject { described_class.new(zip) }

  describe '#call' do
    let(:zip) { 501 }

    context 'when there is no ZipCbsa record for given zip' do
      let(:not_available) do
        {
          Zip: zip,
          CBSA: 99999,
          MSA: 'N/A',
          Pop2015: 'N/A',
          Pop2014: 'N/A'
        }
      end

      it 'returns an empty data hash' do
        expect(subject.call).to eq(not_available)
      end
    end

    context 'when there is a ZipCbsa record for given zip' do
      let!(:zip_cbsa) { FactoryBot.create(:zip_cbsa, zip: zip, cbsa: '12345') }
      let!(:msa) { FactoryBot.create(:metropolitan_statistical_area, cbsa: cbsa) }
      let(:data_hash) do
        {
          Zip: zip,
          CBSA: cbsa,
          MSA: msa.name,
          Pop2015: msa.popestimate2015,
          Pop2014: msa.popestimate2014
        }
      end

      context 'when the cbsa for the given zip is in the mdiv column' do
        let!(:mdiv_cbsa) { FactoryBot.create(:mdiv_cbsa, mdiv: zip_cbsa.cbsa, cbsa: '98765') }
        let(:cbsa) { mdiv_cbsa.cbsa }

        it 'returns the MSA data that corresponds to cbsa associated with the mdiv' do
          expect(subject.call).to eq(data_hash)
        end
      end

      context 'when the cbsa for the given zip is in the cbsa column' do
        let(:cbsa) { zip_cbsa.cbsa }

        it 'returns the MSA data that corresponds to the original zip cbsa' do
          expect(subject.call).to eq(data_hash)
        end
      end
    end
  end
end
