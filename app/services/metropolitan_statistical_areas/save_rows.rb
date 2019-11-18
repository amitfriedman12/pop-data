module MetropolitanStatisticalAreas
  class SaveRows
    MSA = 'Metropolitan Statistical Area'.freeze
    attr_reader :rows

    def initialize(rows)
      @rows = rows
    end

    def self.call(rows:)
      new(rows).call
    end

    def call
      rows.each do |row|
        SaveRow.call(row: row) if row.lsad === MSA
        ::MdivCbsas::SaveRow.call(row: row) if row.mdiv.present?
      end
    end
  end
end