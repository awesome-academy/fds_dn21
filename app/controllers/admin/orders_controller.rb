class Admin::OrdersController < ApplicationController
  before_action :load_order, only: :update
  def index
    @orders = Order.all.order_by_created_time.page(params[:page]).per(
      Settings.paging_sm
    )
  end

  def update
    if @order.update status: Order.statuses[@order.status] + 1
      respond_to do |format|
        format.html{redirect_to admin_orders_path}
        format.js
      end
    else
      flash[:danger] = t "flash.update_fail"
      redirect_to admin_orders_path
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:warning] = t "flash.not_found"
    redirect_to admin_path
  end
end
