class Admin::CategoriesController < Admin::AdminsController
  before_action :load_category, only: :destroy
  before_action :load_all_categories, only: [:index, :new, :destroy]

  def index; end

  def new
    @category = Category.new
    respond_to do |format|
      format.html{redirect_to admin_categories_path}
      format.js
    end
  end

  def destroy
    if @category.update_attribute :is_deleted, true
      respond_to do |format|
        format.html{redirect_to admin_categories_path}
        format.js
      end
    else
      flash[:danger] = t "flash.action_failed"
      render :index
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t "flash.created"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :picture, :parent_id
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t "flash.not_found"
    redirect_to admin_path
  end

  def load_all_categories
    @categories = Category.all.order_by_name.page(params[:page]).per(
      Settings.paging
    )
  end
end
