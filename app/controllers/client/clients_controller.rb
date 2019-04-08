class Client::ClientsController < ApplicationController
  def index; end
  
  include Client::CartsHelper
end
