class Admin::AdminsController < ApplicationController
  before_action :admin_permissions
  authorize_resource
  def index; end

  def admin_permissions
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
