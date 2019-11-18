class MetropolitanStatisticalArea < ApplicationRecord
  validates_presence_of :cbsa
  validates_uniqueness_of :cbsa
end
