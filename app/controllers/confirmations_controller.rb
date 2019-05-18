class ConfirmationsController < Devise::ConfirmationsController
  before_action :authenticate_user!

  def new
    super
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def create
    self.resource = resource_class.send_confirmation_instructions(
      resource_params
    )
    yield resource if block_given?
    @sented = successfully_sent?(resource)
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end
end
