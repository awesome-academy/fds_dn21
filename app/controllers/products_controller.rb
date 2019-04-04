class ProductsController < ApplicationController
  before_action :load_all_products, only: :index

  def index; end

  private
  def load_all_products
    @products = Product.order_by_name.page(
      params[:page]
    ).per(Settings.paging)
  end
end
