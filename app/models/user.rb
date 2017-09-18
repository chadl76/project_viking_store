class User < ApplicationRecord
	has_many :addresses
	has_many :orders
	has_many :credit_cards

	has_many :order_products, through:  :orders, :source => :products

	belongs_to :billing_address, :foreign_key => :billing_id, class_name: :"Address"
	belongs_to :shipping_address, :foreign_key => :shipping_id, class_name: :"Address"

	def self.new_users(num_day)
		where("created_at > ?", Time.now - num_day.days).count
	end

	def self.top_states
		sql = "SELECT COUNT(first_name) AS total, states.name FROM users JOIN addresses ON users.billing_id = addresses.id JOIN states ON addresses.state_id = states.id GROUP BY states.name ORDER BY total DESC LIMIT 3"

		results = ActiveRecord::Base.connection.exec_query(sql)
		
		results.rows
	end

	def self.top_cities
		sql = "SELECT COUNT(first_name) AS total, cities.name FROM users JOIN addresses ON users.billing_id = addresses.id JOIN cities ON addresses.city_id = cities.id GROUP BY cities.name ORDER BY total DESC LIMIT 3"

		results = ActiveRecord::Base.connection.exec_query(sql)
		
		results.rows
	end


	def self.most_orders_by_user
		sql = "SELECT COUNT(orders.id) AS total, users.first_name || ' ' || users.last_name AS name FROM orders JOIN users ON orders.user_id = users.id WHERE orders.checkout_date IS NOT NULL GROUP BY name ORDER BY total DESC LIMIT 1"
		
		results = ActiveRecord::Base.connection.exec_query(sql)

		results.rows
	end

	def self.user_with_highest_order
		sql = "SELECT users.first_name || ' ' || users.last_name AS name, (products.price * order_contents.quantity) AS total FROM order_contents JOIN orders ON order_contents.order_id = orders.id JOIN users ON users.id = orders.user_id JOIN products ON order_contents.product_id = products.id ORDER BY total DESC LIMIT 1"
		
		results = ActiveRecord::Base.connection.exec_query(sql)

		results.rows
	end

	def self.user_with_avg_highest_order
		sql = "SELECT users.first_name || ' ' || users.last_name AS name, AVG(products.price * order_contents.quantity) AS total FROM order_contents JOIN orders ON order_contents.order_id = orders.id JOIN users ON users.id = orders.user_id JOIN products ON order_contents.product_id = products.id GROUP BY users.first_name, users.last_name LIMIT 1"
		
		results = ActiveRecord::Base.connection.exec_query(sql)

		results.rows
	end



	
end
