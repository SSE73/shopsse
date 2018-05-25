class Shopping < ApplicationRecord
  belongs_to :tovar
  belongs_to :cart
end
