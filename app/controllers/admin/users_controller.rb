class Admin::UsersController < ApplicationController
  def index
  	@user = User.all
  	#@city = User.addresses.first.city
  end
end
