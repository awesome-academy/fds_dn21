class CartsController < ApplicationController
  before_action :load_product, only: [:create, :destroy]
  before_action :current_order, only: :show

  def show
    @order_products = []
    session[:shopping_cart].each do |e|
      @order_products << OrderProduct.new(e)
    end
  end

  def create
    order_product = OrderProduct.new item_params
    session[:shopping_cart] << order_product
    flash[:success] = t ".success_add"
    redirect_to cart_path
  end

  def destroy
    session[:shopping_cart].each do |item|
      session[:shopping_cart].delete(item) if item["product_id"] == @product.id
    end
    flash[:success] = t ".success_delete"
    redirect_to cart_path
  end

  private

  def item_params
    params.permit :product_id
  end

  def load_product
    current_order
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.not_found_product"
    redirect_to root_path
  end
end
