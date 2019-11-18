module MetropolitanStatisticalAreas
  class SaveRow
    attr_reader :row

    def initialize(row)
      @row = row
    end

    def self.call(row:)
      new(row).call
    end

    def call
      record = ::MetropolitanStatisticalArea.find_or_initialize_by(cbsa: row.cbsa)
      record.assign_attributes(
        name: row.name,
        popestimate2014: row.popestimate2014,
        popestimate2015: row.popestimate2015
      )
      record.save!
    end
  end
end
