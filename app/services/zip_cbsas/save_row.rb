module ZipCbsas
  class SaveRow
    attr_reader :row

    def initialize(row)
      @row = row
    end

    def self.call(row:)
      new(row).call
    end

    def call
      # .zip is a saved method in ruby that converts a hash to an array of arrays
      record = ::ZipCbsa.find_or_initialize_by(zip: row[:zip])
      record.cbsa = row.cbsa
      record.save # some records with cbsa 99999 will fail silently and will not be saved
    end
  end
end
