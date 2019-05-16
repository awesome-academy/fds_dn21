module Client::RatesHelper
  include MyModules::Rates
  def is_allow_to_rate? product
    return false if !user_signed_in? ||
                    current_user.admin? ||
                    current_user.rates.find_by(product_id: product.id)
    current_user.orders.each do |order|
      next unless order.delivered?
      order.order_products.each do |order_product|
        return true if order_product.product_id == product.id
      end
    end
    false
  end
end
