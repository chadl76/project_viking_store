class Order < ApplicationRecord
	belongs_to :user, foreign_key: :user_id

	has_many :order_contents
	has_many :products, through: :order_contents

	def self.order_total
		Order.all.count
	end

	def self.orders_placed(num_day)
		find_by_sql("SELECT checkout_date FROM orders WHERE (checkout_date > current_date - #{num_day}) ORDER BY checkout_date DESC").count
	end



	


end
