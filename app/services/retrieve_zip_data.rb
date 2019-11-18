class RetrieveZipData
  attr_reader :zip

  def initialize(zip)
    @zip = zip
  end

  def self.call(zip:)
    new(zip).call
  end

  def call
    return not_available unless zip_cbsa.present?
    data_hash
  end

  private

  def zip_cbsa
    @zip_cbsa ||= ZipCbsa.find_by(zip: zip).try(:cbsa)
  end

  def not_available
    {
      Zip: zip,
      CBSA: 99999,
      MSA: 'N/A',
      Pop2015: 'N/A',
      Pop2014: 'N/A'
    }
  end

  def mdiv_cbsa
    @mdiv_cbsa ||= MdivCbsa.find_by(mdiv: zip_cbsa).try(:cbsa)
  end

  def msa
    @msa ||= MetropolitanStatisticalArea.find_by(cbsa: cbsa)
  end

  def cbsa
    @cbsa ||= mdiv_cbsa || zip_cbsa
  end

  def data_hash
    {
      Zip: zip,
      CBSA: cbsa,
      MSA: msa.name,
      Pop2015: msa.popestimate2015,
      Pop2014: msa.popestimate2014
    }
  end
end
