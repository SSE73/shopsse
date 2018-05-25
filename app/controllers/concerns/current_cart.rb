module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @i2 = 0 # для подсчета порядкового номера приоформлении заказа ( carts/_cart_row.html.erb )

    #   @cart = Cart.find(session[:cart_id])
    # rescue ActiveRecord::RecordNotFound
    #   @cart = Cart.create
    #   session[:cart_id] = @cart.id

    if user_signed_in?
      @user = User.find(current_user.id)
      @cart = Cart.find_by(user_id: @user.id)
      # session[:cart_id] = @cart.id

      if @cart.nil? # Если НЕТ корзины у конкретного пользователя

        @cart = Cart.find(session[:cart_old])
        @cart.user_id = @user.id
        @cart.save

        add_line_items_from_current_cart(Cart.find(session[:cart_old]))

        @i11112 = 0 # для отладчика

      else # Если ЕСТЬ корзина у конкретного пользователя

        session[:cart_id] = @cart.id

        if  session[:cart_old] != session[:cart_id]

          # Проверяется НЕТ ли в корзине выбранных товаров ( Корзина пуста? )

          add_line_items_from_current_cart(Cart.find(session[:cart_old]))

          @i11112 = 0 # для отладчика

        end

      end

    else
      @cart = Cart.find(session[:cart_id])
      # @i11112 = 0 # для отладчика
    end

  rescue ActiveRecord::RecordNotFound
    if user_signed_in?
      # Если НЕТ корзины у конкретного пользователя
      # @cart = Cart.create
      @i11112 = 0 # для отладчика

    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @cart_old = session[:cart_id]
      session[:cart_old] = @cart.id
    end

  end

  # @order.add_line_items_from_cart(@cart)

  def add_line_items_from_current_cart(cart)
    #add_line_items_from_current_cart(cart) #order.rb
    cart.line_items.each do |item|
      @i11112 = 0 # для отладчика

      @current_line_item = LineItem.find_by(user_id: @cart.user_id, tovar_razmer_id: item.tovar_razmer_id)
      # current_item = @current_line_item

      if @current_line_item
        @current_line_item.quantity += 1

        @current_line_item.save

        item.cart_id = nil
        item.destroy

      else

        item.cart_id = @cart.id
        item.user_id = @cart.user_id

        item.save

      end

      # item.save

    end
  end

end
