class Client::ClientsController < ApplicationController
  before_action :user_permissions
  authorize_resource
  def index; end

  def user_permissions
    unless user_signed_in? && current_user.active?
      redirect_to root_path
    end
  end

  include Client::CartsHelper
end
