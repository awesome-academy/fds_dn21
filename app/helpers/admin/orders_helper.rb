module Admin::OrdersHelper
  include MyModules::Orders
  def render_status order
    render "status", order: order
  end

  def render_update_status order
    render "update_status", order: order
  end

  def render_status_label order
    case Order.statuses[order.status]
    when Settings.order_status_ready
      "primary"
    when Settings.order_status_accepted
      "warning"
    when Settings.order_status_delivering
      "info"
    when Settings.order_status_delivered
      "success disabled"
    end
  end
end
