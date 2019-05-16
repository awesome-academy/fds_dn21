class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource_persisted
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js
      end
    end
  end

  def resource_persisted
    if resource.active_for_authentication?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end
end
