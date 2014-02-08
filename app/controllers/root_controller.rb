class RootController < ApplicationController
  skip_authorization_check
  before_action :authenticate_user!
  
  def index
  end
end
