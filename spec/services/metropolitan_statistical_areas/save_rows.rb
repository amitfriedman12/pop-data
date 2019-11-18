require 'rails_helper'

RSpec.describe MetropolitanStatisticalAreas::SaveRows do
  subject { described_class.new(rows) }

  describe '#call' do
    let(:rows) do
      [
        Hashie::Mash.new('cbsa' => '10180', 'mdiv' => nil, 'name' => 'Abilene, TX', 'lsad' => 'Metropolitan Statistical Area', 'popestimate2014' => 168380, 'popestimate2015' => 169578),
        Hashie::Mash.new('cbsa' => '10180', 'mdiv' => '48059', 'name' => 'Callahan County, TX', 'lsad' => 'County or equivalent'),
        Hashie::Mash.new('cbsa' => '10180', 'mdiv' => '48253', 'name' => 'Jones County, TX', 'lsad' => 'County or equivalent'),
        Hashie::Mash.new('cbsa' => '10180', 'mdiv' => '48441', 'name' => 'Taylor County, TX', 'lsad' => 'County or equivalent')
      ]
    end

    it 'creates 1 new MetropolitanStatisticalArea record' do
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

    it 'creates 3 new MdivCbsa records' do
      expect {
        subject.call
      }.to change { MdivCbsa.count }.by(3)
      expect(MdivCbsa.last).to have_attributes(mdiv: '48441', cbsa: '10180')
    end
  end
end
