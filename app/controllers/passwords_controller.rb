class PasswordsController < Devise::PasswordsController
  before_action :authenticate_user!

  def new
    self.resource = resource_class.new
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(
      resource_params
    )
    yield resource if block_given?
    @sented = false
    @sented = true if successfully_sent?(resource)
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end
end
