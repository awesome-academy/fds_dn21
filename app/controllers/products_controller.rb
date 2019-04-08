class ProductsController < ApplicationController
  before_action :load_all_products, only: :index
  before_action :load_product, only: :show

  def index; end

  def show
    @order_product = OrderProduct.new
  end

  private
  def load_all_products
    @products = Product.order_by_name.page(
      params[:page]
    ).per Settings.paging
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t "flash.not_found"
    redirect_to admin_path
  end
end
