class Address < ApplicationRecord
	belongs_to :user, foreign_key: :user_id
	belongs_to :city, foreign_key: :city_id, :class_name => "City"
	belongs_to :state
end
