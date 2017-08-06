class User < ApplicationRecord

	def self.new_users(num_day)
		where("created_at > ?", Time.now - num_day.days).count
	end
	
end
