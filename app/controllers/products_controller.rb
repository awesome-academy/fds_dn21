class ProductsController < ApplicationController
  before_action :load_all_products, only: :index
  before_action :load_product, :build_rate, :load_rates, only: :show

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.page(params[:page])
  end

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
    redirect_to client_path
  end

  def build_rate
    @rate = Rate.new
  end

  def load_rates
    @rates = @product.rates.order_by_created_time
  end
end
