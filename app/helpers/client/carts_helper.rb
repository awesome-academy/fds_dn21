module Client::CartsHelper
  def current_order
    session[:shopping_cart] ||= []
  end
end
