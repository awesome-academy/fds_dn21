class SessionsController < Devise::SessionsController
  before_action :authenticate_user!
end
