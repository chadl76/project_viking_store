class DashboardController < ApplicationController

	def index

		#1. OVERALL PLATFORM TOTALS
		@user_total = User.all.count
		@order_total = Order.order_total
		@product_total = Product.product_total
		@revenue = OrderContent.get_revenue

		# 1. OVERALL PLATFORM 7 DAY TOTALS
		@new_user_7 = User.new_users(7)
		@orders_placed_7 = Order.orders_placed(7)
		@new_products_7 = Product.new_products(7)
		@revenue_7 = OrderContent.get_revenue_by_day(7)
		
		#1. OVERALL PLATFORM 30 DAY TOTALS
		@new_user_30 = User.new_users(30)
		@revenue_30 = OrderContent.get_revenue_by_day(30)
		@new_products_30 = Product.new_products(30)
		
		#2. USER DEMOGRAPHICS AND BEHAVOIR
		@user_top_states = User.top_states
		@user_top_cities = User.top_cities
		@most_order_by_user = User.most_orders_by_user
		@user_with_highest_order = User.user_with_highest_order
		@user_with_avg_highest_order = User.user_with_avg_highest_order
		
		#3. ORDER STATISTICS
		@orders_placed_30 = Order.orders_placed(30)
		@order_avg_7 = Order.avg_order_value(7)
		@largest_order_7 = Order.largest_order_value(7)
		@largest_order_30 = Order.largest_order_value(30)
		@order_avg_30 = Order.avg_order_value(30)
		@avg_order_total = Order.avg_order_total
		@largest_order = Order.largest_order
		#binding.pry
		
	end

end
