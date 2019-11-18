require 'rails_helper'

RSpec.describe MdivCbsas::SaveRow do
  subject { described_class.new(row) }

  describe '#call' do
    context 'new record' do
      let(:row) { Hashie::Mash.new('mdiv' => '20524', 'cbsa' => '35620') }

      it 'creates 1 new mdiv_cbsa record' do
        expect {
          subject.call
        }.to change { MdivCbsa.count }.by(1)
        expect(MdivCbsa.last).to have_attributes(mdiv: '20524', cbsa: '35620')
      end
    end

    context 'existing record' do
      let(:row) { Hashie::Mash.new('mdiv' => '31084', 'cbsa' => '12345') }
      let!(:existing_mdiv_cbsa) { FactoryBot.create(:mdiv_cbsa) } # mdiv = 31084

      it 'updates the cbsa of the existing record' do
        expect {
          subject.call
        }.to_not change { MdivCbsa.count }
        expect(existing_mdiv_cbsa.reload.cbsa).to eq('12345')
      end
    end
  end
end
