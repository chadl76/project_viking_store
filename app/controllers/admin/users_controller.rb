class Admin::UsersController < ApplicationController
	include Admin::UsersHelper
  def index
  	@user = User.all
  	#@city = User.addresses.first.city
  end

  def show
  	@user = User.find(params[:id])
  	
  	@user_shipping_address = get_address(@user)
  
  end
end
