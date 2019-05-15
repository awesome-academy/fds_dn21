class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :load_list_products, :load_cart, :sign_up

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

  def sign_up
    @user = User.new
  end

  protect_from_forgery with: :exception
  include SessionsHelper
end
