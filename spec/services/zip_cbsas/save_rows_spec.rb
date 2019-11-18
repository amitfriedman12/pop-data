require 'rails_helper'

RSpec.describe ZipCbsas::SaveRows do
  subject { described_class.new(rows) }
  let(:rows) do
    [
      Hashie::Mash.new('zip' => '501', 'cbsa' => '12345'),
      Hashie::Mash.new('zip' => '601', 'cbsa' => '10260'),
      Hashie::Mash.new('zip' => '606', 'cbsa' => '99999')
    ]
  end
  let!(:existing_zip_cbsa) { FactoryBot.create(:zip_cbsa) } # zip = 501

  describe '#call' do
    it 'creates new zip_cbsa records if valid, updates the existing records' do
      expect {
        subject.call
      }.to change { ZipCbsa.count }.by(1)
      expect(existing_zip_cbsa.reload.cbsa).to eq('12345')
      expect(ZipCbsa.last).to have_attributes(zip: '601', cbsa: '10260')
    end
  end
end
