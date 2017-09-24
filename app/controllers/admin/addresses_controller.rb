class Admin::AddressesController < ApplicationController
	before_action :get_address, only: [:show]


	def index
		#@addresses = Address.all
		if params[:user_id]
			if User.exists?(params[:user_id])
				@user = User.find(params[:user_id])
				@addresses = Address.where(user_id: @user.id)
			else
				flash[:error] = "Invalid User Id"
				redirect_to admin_addresses_path
			end
		else
			@addresses = Address.all
		end
	end

	def show
		#@addr = Address.find(params[:id])
		#@user = User.find(params[:user_id])
		#@address = @user.addresses
		@address = Address.find(params[:id])
	 
		
		
	end


	private

	def address_params
		params.require(:addresses)
	end

	def get_address
		@address = Address.find(params[:id])
	end

	

	
end
