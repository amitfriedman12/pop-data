module MdivCbsas
  class SaveRow
    attr_reader :row

    def initialize(row)
      @row = row
    end

    def self.call(row:)
      new(row).call
    end

    def call
      record = ::MdivCbsa.find_or_initialize_by(mdiv: row.mdiv)
      record.cbsa = row.cbsa
      record.save!
    end
  end
end