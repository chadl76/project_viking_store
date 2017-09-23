class Admin::AddressesController < ApplicationController

	def index
		@addresses = Address.all
		
	end

	def show
		@addr = Address.find(params[:id])
		@user = User.find(params[:user_id])
		@address = @user.addresses

	 
		
		
	end


	private
	def address_params
		params.require(:addresses)
	end

end
