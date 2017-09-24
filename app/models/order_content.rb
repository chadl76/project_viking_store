class OrderContent < ApplicationRecord
	belongs_to :order
	belongs_to :product
	#private
	def self.get_revenue
		sql = "SELECT SUM(price * quantity) AS total FROM order_contents JOIN products ON products.id = order_contents.product_id"
		
		result =  ActiveRecord::Base.connection.exec_query(sql)
		
		result.rows[0][0]
	end

	def self.get_revenue_by_day(num_day)
		sql = "SELECT SUM(price * quantity) AS total, orders.checkout_date FROM order_contents JOIN products ON products.id = order_contents.product_id JOIN orders ON orders.id = order_contents.order_id WHERE(orders.checkout_date > current_date - #{num_day}) GROUP BY orders.checkout_date ORDER BY checkout_date DESC"
		result =  ActiveRecord::Base.connection.exec_query(sql)

		sum = 0		
		total = result.rows.each { |x| sum += x[0].to_i.round(2)}
		sum
	end

	#def self.product_total_ordered
	#	find_by_sql("SELECT order_contents.product_id, order_contents.quantity FROM order_contents JOIN products on products.id = order_contents.product_id JOIN orders ON orders.id = order_contents.order_id GROUP BY order_conents.product_id ORDER BY order_contents.quantity")
	#end

	def value
		product.price * quantity
	end


end


