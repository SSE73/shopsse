class Manufacturer < ApplicationRecord
  has_many :tovars
  validates :name, uniqueness: true, presence: true
  
end
