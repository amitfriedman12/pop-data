module ZipCbsas
  class SaveRows
    attr_reader :rows

    def initialize(rows)
      @rows = rows
    end

    def self.call(rows:)
      new(rows).call
    end

    def call
      rows.each do |row|
        SaveRow.call(row: row)
      end
    end
  end
end
