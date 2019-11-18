class MdivCbsa < ApplicationRecord
  validates_presence_of :mdiv, :cbsa
  validates_uniqueness_of :mdiv
end
