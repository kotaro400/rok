class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_signed_in

  def top
  end
  
end
