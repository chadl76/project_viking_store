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

	def new
		@address = Address.new(user_id: params[:user_id])
	end

	def edit
		@address = Address.find(params[:id])
	end


	def show
		@address = Address.find(params[:id])
	 end

	 def create
	 	@address = Address.new(whitelisted_address_params)
	 	if @address.save
	 		flash[:success] = "New address created"
	 		redirect_to admin_user_addresses_path(@address.user_id)
	 	else
	 		flash.now[:error] = "Failed to create new addresss."
	 		render 'new'
	 	end
	 end

	 def update
	 	if @address.update_attributes(whitelisted_address_params)
	 		flash[:success] = "Address updated!"
	 		redirect_to admin_user_addresses_path
	 	else
	 		flash.now[:error] = "Failed to update address"
	 		render 'new'
	 	end
	 end


	private

	def whitelisted_address_params
		params.require(:address).permit(:street_address, :state_id, :city_id, :user_id, :zip_code)
	end

	def get_address
		@address = Address.find(params[:id])
	end

	

	
end
