class Admin::ProductsController < Admin::AdminsController
  before_action :load_product, except: %i(index new create)
  before_action :load_all_products, except: %i(show edit update)
  before_action :load_all_categories, only: %i(new edit)

  def index; end

  def show; end

  def new
    @product = Product.new
    respond_to do |format|
      format.html{redirect_to admin_products_path}
      format.js
    end
  end

  def destroy
    if @product.update_attribute :is_deleted, true
      respond_to do |format|
        format.html{redirect_to admin_products_path}
        format.js
      end
    else
      flash[:danger] = t "flash.action_failed"
      render :index
    end
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:info] = t "flash.created"
      @save = true
    else
      @save = false
      flash[:danger] = t "flash.action_failed"
    end
    respond_to do |format|
      format.html{redirect_to admin_products_path}
      format.js
    end
  end

  def edit; end

  def update
    if @product.update_attributes product_params
      flash[:info] = t "flash.updated"
      redirect_to admin_products_path
    else
      respond_to do |format|
        format.html{redirect_to admin_products_path}
        format.js
      end
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :category_id,
      :information, :price, :quantity, :picture
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t "flash.not_found"
    redirect_to admin_path
  end

  def load_all_products
    @products = Product.all.order_by_name.page(params[:page]).per(
      Settings.paging
    )
  end

  def load_all_categories
    @categories = Category.all.order_by_name
  end
end
