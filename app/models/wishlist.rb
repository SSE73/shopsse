class Wishlist < ApplicationRecord
  belongs_to :tovar_razmer
  belongs_to :cart

  belongs_to :user

end
