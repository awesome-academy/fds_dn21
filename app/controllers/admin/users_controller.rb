class Admin::UsersController < Admin::AdminsController
  before_action :load_user, :is_admin?, only: :destroy

  def index
    @users = User.sort_by_created_at.page(params[:page]).per Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete"
      redirect_to admin_users_path
    else
      flash[:danger] = t "undelete"
      redirect_to admin_root_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "error"
    redirect_to admin_root_path
  end

  def is_admin?
    redirect_to root_path unless current_user.admin?
  end
end
