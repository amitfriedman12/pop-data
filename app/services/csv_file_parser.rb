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
    map_rows(fetch_csv)
  rescue Encoding::UndefinedConversionError => e
    map_rows(fetch_csv.force_encoding('utf-8'))
  rescue StandardError => e
    raise "Could not read the CSV file: #{e.message}"
  end

  def map_rows(csv_file)
    ::CSV.parse(csv_file, headers: true, header_converters: :symbol).map do |row|
      ::Hashie::Mash.new(row.to_hash)
    end
  end

  def fetch_csv
    @fetch_csv ||= begin
      response = Faraday.get(csv_url)
      fail unless response.success?
      response.body
    end
  end
end
