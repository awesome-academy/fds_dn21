module ApplicationHelper
  def full_title page_title
    base_title = t("base.base_title")
    page_title.blank? ? base_title : page_title + " | " + base_title
  end

  def get_role_name
    if current_user.admin?
      t "generals.admins"
    else
      t "generals.client"
    end
  end

  def current_order
    session[:cart] ||= {}
  end

  def render_application
    if user_signed_in? && current_user.admin?
      render "layouts/admin/admin"
    else
      render "layouts/client/client_application"
    end
  end

  def create_index params_page, index, per_page
    params_page = Settings.per_index || params_page
    ((params_page.to_i - Settings.per_index) * per_page.to_i) +
      index.to_i + Settings.per_index
  end
end
