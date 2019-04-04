class ApplicationController < ActionController::Base
  before_action :set_locale

  helper_method :current_order

  def current_order
    session[:shopping_cart] ||= []
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protect_from_forgery with: :exception
  include SessionsHelper

end
