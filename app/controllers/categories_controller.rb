class CategoriesController < ApplicationController
  before_action :load_category, :load_products_by_category,
    :load_child_categories, only: :show
  before_action :load_all_categories, only: :index

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.page(params[:page])
  end

  def show; end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t "flash.not_found"
    redirect_to admin_path
  end

  def load_products_by_category
    @products = @category.products
  end

  def load_all_categories
    @categories = Category.order_by_name.page(params[:page]).per(
      Settings.paging
    )
  end

  def load_child_categories
    @categories = Category.load_child_categories(@category).order_by_name
  end
end
