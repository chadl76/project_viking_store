class Order < ApplicationRecord
	belongs_to :user, foreign_key: :user_id
    belongs_to :shipping_address, foreign_key: :shipping_id, class_name: "Address"

	has_many :order_contents
	has_many :products, through: :order_contents

	def self.order_total
		Order.all.count
	end

	def self.orders_placed(num_day)
		find_by_sql("SELECT checkout_date FROM orders WHERE (checkout_date > current_date - #{num_day}) ORDER BY checkout_date DESC").count
	end

	def self.avg_order_total
		joins("JOIN order_contents ON order_contents.order_id = orders.id").joins("JOIN products ON order_contents.product_id = products.id").where("orders.checkout_date IS NOT NULL").average("products.price").round(2)
		#binding.pry
	end

	def self.avg_order_value(num_day)
		joins("JOIN order_contents ON order_contents.order_id = orders.id").joins("JOIN products ON order_contents.product_id = products.id").where("orders.checkout_date IS NOT NULL AND orders.checkout_date > current_date - ?", num_day).average("products.price").to_f.round(2)
	end

	def self.largest_order_value(num_day)
		sql = ("SELECT products.price * order_contents.quantity AS total FROM products JOIN order_contents ON products.id = order_contents.product_id JOIN orders ON orders.id = order_contents.order_id WHERE orders.checkout_date > (current_date - #{num_day}) ORDER BY total DESC LIMIT 1")
		result = ActiveRecord::Base.connection.exec_query(sql)
		total = result.rows[0]
		total.to_s.to_i.round(2)
	

	end

	def self.largest_order
		sql = "SELECT products.price * order_contents.quantity AS total FROM products JOIN order_contents ON products.id = order_contents.product_id JOIN orders ON orders.id = order_contents.order_id ORDER BY total DESC LIMIT 1"
		result = ActiveRecord::Base.connection.exec_query(sql)
		total = result.rows[0]
		total[0]
	end

	def value
		products.sum("quantity * price")
	end

	def join_order_contents_on_order
		"JOIN order_contents ON order_contents.order_id = orders.id"
	end
	





	


end
