class HomeController < ApplicationController

  include CurrentCart
  before_action :set_cart

  def index

    # if current_user.nil?
    #
    #   @tovars = Tovar
    #   #Устанавливаем сортировку
    #   order = params[:order] == "asc" ? "asc" : "desc"
    #   @tovars = @tovars.order("popul #{order}" )
    #
    #   #@tovars = @tovars.order("created_at #{order}")
    #
    # elsif current_user.admin?
    #   # @tovars = Tovar.order(sort_column+" "+sort_direction).page(params[:page]).per(32)
    #
    # else

      @tovars = Tovar
      #Устанавливаем сортировку
      order = params[:order] == "asc" ? "asc" : "desc"
      @tovars = @tovars.order("popul #{order}" )

      #@tovars = @tovars.order("created_at #{order}")

  #   end
  end
end
