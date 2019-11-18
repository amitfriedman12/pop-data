require 'rails_helper'

RSpec.describe MetropolitanStatisticalAreas::SaveRow do
  subject { described_class.new(row) }

  describe '#call' do
    context 'new record' do
      let(:row) do
        Hashie::Mash.new('cbsa' => '10180', 'name' => 'Abilene, TX', 'popestimate2014' => 168380, 'popestimate2015' => 169578)
      end

      it 'creates a new MetropolitanStatisticalArea record' do
        expect {
          subject.call
        }.to change { MetropolitanStatisticalArea.count }.by(1)
        expect(MetropolitanStatisticalArea.last).to have_attributes(
          cbsa: '10180',
          name: 'Abilene, TX',
          popestimate2014: 168380,
          popestimate2015: 169578
        )
      end
    end

    context 'existing record' do
      let(:row) do
        Hashie::Mash.new('cbsa' => '31080', 'name' => 'Los Angeles-Long Beach-Anaheim, CA', 'popestimate2014' => 111111111, 'popestimate2015' => 222222222)
      end
      let!(:existing_msa) { FactoryBot.create(:metropolitan_statistical_area) } # cbsa = 31080

      it 'updates the the existing MetropolitanStatisticalArea record' do
        expect {
          subject.call
        }.to_not change { MetropolitanStatisticalArea.count }
        expect(existing_msa.reload.popestimate2014).to eq(111111111)
        expect(existing_msa.reload.popestimate2015).to eq(222222222)
      end
    end
  end
end
