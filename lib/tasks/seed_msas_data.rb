# frozen_string_literal: true

task :seed_msas_data, %w[csv_url] => [:environment] do |_t, args|
  fail 'No CSV url provided in arguments!' unless args[:csv_url]

  MetropolitanStatisticalAreas::SaveRows.call(
    rows: CsvFileParser.call(csv_url: args[:csv_url])
  )
end
