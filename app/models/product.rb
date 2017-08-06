class Product < ApplicationRecord
	def self.product_total
		Product.all.count
	end

	def self.new_products(num_day)
		where("created_at > ?", Time.now - num_day.days).count
	end

end
