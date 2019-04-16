class Client::CartsController < Client::ClientsController
  before_action :current_order, only: [:index, :create, :destroy]

  def index
    @items = []
    session[:shopping_cart].each do |e|
      @items << OrderProduct.new(e) if e["product_id"]
    end
  end

  def create
    load_product item_params[:product_id]
    if item_params[:quantity].to_i <= Settings.lowest_quantity
      respond_to do |format|
        format.html{redirect_to product_path(@product.id)}
        format.js
      end
    elsif @product.quantity < item_params[:quantity].to_i
      respond_to do |format|
        format.html{redirect_to product_path(@product.id)}
        format.js
      end
    else
      session[:shopping_cart].each do |item|
        if item["product_id"] == @product.id
          a = item["quantity"].to_i
          b = item_params[:quantity].to_i
          a+=b
          item["quantity"] = a
          remain_quantity = @product.quantity - b
          @product.update_attribute :quantity, remain_quantity
          flash[:success] = t "added"
          redirect_to products_path
          return
        end
      end
      order_product = OrderProduct.new item_params
      session[:shopping_cart] << order_product
      remain_quantity = @product.quantity - item_params[:quantity].to_i
      @product.update_attribute :quantity, remain_quantity
      flash[:success] = t "success_add"
      redirect_to products_path
    end
  end

  def destroy
    load_product params["id"].to_i
    session[:shopping_cart].each do |item|
      remain_quantity = @product.quantity + item["quantity"].to_i
      @product.update_attribute :quantity, remain_quantity
      session[:shopping_cart].delete(item) if item["product_id"] == params[:id].to_i
    end
    flash[:success] = t "success_delete"
    redirect_to client_carts_path
  end

  private

  def item_params
    params.require(:order_product).permit :product_id, :price, :quantity
  end

  def load_product id
    @product = Product.find_by id: id
    return if @product
    flash[:danger] = t "not_found_product"
    redirect_to products_path
  end
end
