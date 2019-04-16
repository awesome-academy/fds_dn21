class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update, :show]

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "static_pages.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email,
      :address, :phone, :password, :password_confirmation
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
