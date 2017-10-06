class Admin::OrdersController < ApplicationController
	before_action :get_order, only: [:show]
	

	def index
		if params[:user_id]
			if User.exists?(params[:user_id])
				@user = User.find(params[:user_id])
				@orders = Order.where(user_id: @user.id)
			else
				flash[:error] = "Invalid User Id"
				redirect_to admin_user_orders_path
			end
		else
			@orders = Order.all
		end
	end

	def show
	end

	private 

	def get_order
		@order = Order.find(params[:id])
	end


end
