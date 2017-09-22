class Admin::AddressesController < ApplicationController

	def index
		@addresses = Address.all
	end

	def show
		@address = Address.find(params[:id])
		@user = @address.user
	end


	private
	def address_params
		params.require(:addresses)
	end

end
