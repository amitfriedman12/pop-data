require 'csv'

class CsvFileParser
  attr_reader :csv_url

  def initialize(csv_url)
    @csv_url = csv_url
  end

  def self.call(csv_url:)
    new(csv_url).call
  end

  def call
    ::CSV.parse(csv_file, headers: true, header_converters: :symbol).map do |row|
      ::Hashie::Mash.new(row.to_hash)
    end
  rescue StandardError => e
    raise "Could not read the CSV file: #{e.message}"
  end

  def csv_file
    @csv_file ||= fetch_csv.force_encoding('utf-8')
  end

  def fetch_csv
    response = Faraday.get(csv_url)
    fail unless response.success?
    response.body
  end
end
