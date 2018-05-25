class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_one :reception


  # VALID_TELEPHONE_REGEX = /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/

  validates :name,  presence: true, length: { maximum: 50 }
  validates :telephone, presence: true  #, format: { with: VALID_TELEPHONE_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  validates :reception_id,  presence: true

  def add_one_tovar
    tovar = Tovar.find(params[:tovar_id])
    @line_item = @cart.add_tovar(tovar.id)

    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end

  end
end
