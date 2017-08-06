class DashboardController < ApplicationController

	def index
		@user_total = User.all.count
		@order_total = Order.order_total
		@product_total = Product.product_total
		@new_user_7 = User.new_users(7)
		@new_user_30 = User.new_users(30)
		@orders_placed_7 = Order.orders_placed(7)
		@new_products_7 = Product.new_products(7)
		@new_products_30 = Product.new_products(30)
		@revenue = OrderContent.get_revenue
		@revenue_7 = OrderContent.get_revenue_by_day(7)
		@revenue_30 = OrderContent.get_revenue_by_day(30)
	\

		@orders_placed_30 = Order.orders_placed(30)
		#binding.pry
	
	
	end


end
