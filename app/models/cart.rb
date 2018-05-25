class Cart < ApplicationRecord

  has_many :line_items, dependent: :destroy

  has_many :shoppings, dependent: :destroy

  belongs_to :user

  has_many :wishlists, dependent: :destroy


  def add_tovar(tovar_razmer_id)
    current_item = line_items.find_by(tovar_razmer_id: tovar_razmer_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(tovar_razmer_id: tovar_razmer_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_quantity
    line_items.to_a.sum { |item| item.total_quantity }
  end

  def subtotal
    line_items.collect { |oi| oi.valid? ? (oi.quantity * oi.tovar_razmer.price) : 0 }.sum
    #SSE line_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  #Для добавления Ранее просмотренных товаров Date.today

  def add_tovar_shopping(tovar_id)
    current_item = shoppings.find_by(tovar_id: tovar_id)

    if current_item
      # Если товар найден в shoppings, то ничего не делаем
      #current_item.quantity += 1

      current_item.updated_at = DateTime.current
    else
      current_item = shoppings.build(tovar_id: tovar_id)
    end
    current_item
  end

  def add_tovar_wishlist(tovar_razmer_id)
    current_item = wishlists.find_by(tovar_razmer_id: tovar_razmer_id)
    if current_item
      # current_item.quantity += 1
      current_item.quantity = 1
    else
      current_item = wishlists.build(tovar_razmer_id: tovar_razmer_id)
    end
    current_item
  end

end
