class Client::RatesController < Client::ClientsController
  def create
    @rate = Rate.new rate_params
    if @rate.save
      flash[:info] = t "flash.rate_success"
    else
      flash[:warning] = t "flash.rate_fail"
    end
    redirect_to product_path(params[:rate][:product_id])
  end

  private

  def rate_params
    params.require(:rate).permit :rate, :comment, :product_id, :user_id
  end
end
