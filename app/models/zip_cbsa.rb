class ZipCbsa < ApplicationRecord
  validates_presence_of :zip, :cbsa
  validates_uniqueness_of :zip
  validates_exclusion_of :cbsa, in: %w(99999), message: 'The zip code is not part of a CBSA'
end