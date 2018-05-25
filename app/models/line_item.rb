class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :tovar_razmer
  belongs_to :cart

  belongs_to :user

  #SSE belongs_to :razmer

  def total_price
    tovar_razmer.price * quantity
  end

  def total_quantity
    quantity
  end

end
