class Reception < ApplicationRecord
  belongs_to :city
  has_one :order

end
