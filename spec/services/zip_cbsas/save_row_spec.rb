require 'rails_helper'

RSpec.describe ZipCbsas::SaveRow do
  subject { described_class.new(row) }

  describe '#call' do
    context 'new record' do
      context 'valid cbsa' do
        let(:row) { Hashie::Mash.new('zip' => '601', 'cbsa' => '10260') }

        it 'creates 1 new zip_cbsa record' do
          expect {
            subject.call
          }.to change { ZipCbsa.count }.by(1)
          expect(ZipCbsa.last).to have_attributes(zip: '601', cbsa: '10260')
        end
      end

      context 'invalid cbsa' do
        let(:row) { Hashie::Mash.new('zip' => '606', 'cbsa' => '99999') }

        it 'does not create a new zip_cbsa record' do
          expect {
            subject.call
          }.to_not change { ZipCbsa.count }
          expect(ZipCbsa.count).to eq(0)
        end
      end
    end

    context 'existing record' do
      let(:row) { Hashie::Mash.new('zip' => '501', 'cbsa' => '12345') }
      let!(:existing_zip_cbsa) { FactoryBot.create(:zip_cbsa) } # zip = 501

      it 'updates the cbsa of the existing record' do
        expect {
          subject.call
        }.to_not change { ZipCbsa.count }
        expect(existing_zip_cbsa.reload.cbsa).to eq('12345')
      end
    end
  end
end
