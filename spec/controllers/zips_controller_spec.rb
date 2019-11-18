require "rails_helper"

RSpec.describe ZipsController, :type => :controller do
  describe "GET show" do
    let(:zip) { 501 }

    let!(:zip_cbsa) { FactoryBot.create(:zip_cbsa, zip: zip, cbsa: cbsa) }
    let!(:msa) { FactoryBot.create(:metropolitan_statistical_area, cbsa: cbsa) }
    let(:cbsa) { '12345' }
    let(:data_hash) do
      {
        'Zip' => zip.to_s,
        'CBSA' => cbsa,
        'MSA' => msa.name,
        'Pop2015' => msa.popestimate2015,
        'Pop2014' => msa.popestimate2014
      }
    end

    before do
      expect(RetrieveZipData).to receive(:call).with(zip: zip.to_s).and_call_original
    end

    it 'return the zip data' do
      get :show, { id: zip }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq "application/json"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq data_hash
    end
  end
end
