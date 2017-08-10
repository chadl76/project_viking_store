class OrderContent < ApplicationRecord

	#private
	def self.get_revenue
		sql = "SELECT SUM(price * quantity) AS total FROM order_contents JOIN products ON products.id = order_contents.product_id"
		
		result =  ActiveRecord::Base.connection.exec_query(sql)
		
		result.rows[0][0].to_f
	end

	def self.get_revenue_by_day(num_day)
		sql = "SELECT SUM(price * quantity) AS total, orders.checkout_date FROM order_contents JOIN products ON products.id = order_contents.product_id JOIN orders ON orders.id = order_contents.order_id WHERE(orders.checkout_date > current_date - #{num_day}) GROUP BY orders.checkout_date ORDER BY checkout_date DESC"


		
		result =  ActiveRecord::Base.connection.exec_query(sql)

		sum = 0		
		total = result.rows.each { |x| sum += x[0].to_f}
		sum
	end



end


