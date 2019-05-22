class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :store_user_location!, if: :storable_location?
  before_action :load_list_products, :load_cart, :prepare_sign_up
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def load_list_products
    @foods = Category.load_categories_by_classify Settings.clasify_food
    @drinks = Category.load_categories_by_classify Settings.clasify_drink
  end

  def load_cart
    session[:cart] ||= {}
    @items = {}
    session[:cart].each do |key, value|
      item = {}
      load_product_from_cart key
      next unless @product
      item[:product] = @product
      item[:quantity] = value
      @items[key] = item
    end
    load_total_cost @items
  end

  def load_total_cost items
    @total = items.values.reduce(0) do |a, e|
      a + e[:product][:price] * e[:quantity]
    end
  end

  def load_product_from_cart key
    @product = Product.find_by id: key
    return if @product
    session[:cart].except!(key)
  end

  def prepare_sign_up
    @user = User.new
  end

  protect_from_forgery with: :exception

  private

  def storable_location?
    request.get? && is_navigational_format? &&
      !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :remember_me]
    full_attrs = [:name, :email, :password, :remember_me,
                  :address, :phone, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: full_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
