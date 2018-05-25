class SortTovarsController < ApplicationController
  helper_method :sort_column, :sort_direction

  include CurrentCart
  before_action :set_cart

  def sort_all
    #Устанавливаем сортировку
    # @tovars = Tovar.order(sort_column+" "+sort_direction).page(params[:page]).per(12)
    # @products = Product.includes(:variants).order(sort_column+" "+sort_direction)
    @tovars = Tovar.includes(:tovar_razmers).order(sort_column+" "+sort_direction).page(params[:page]).per(12)

  end

  private

  def sort_column
    # Tovar.column_names.include?(params[:sort]) ? params[:sort]: 'title'
    Tovar.column_names.include?(params[:sort]) ? params[:sort]: 'tovar_razmers.price'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end

end
