module Admin::UsersHelper

	def get_address(user)
		address = []
		address << user.shipping_address.street_address

		  #unless user.shipping_address.secondary_address.nil?
			#address << user.shipping_address.secondary_address
		  #end

		address << user.shipping_address.city.name
		address << user.shipping_address.state.name

		address << user.shipping_address.zip_code

		
		return address.join(", ")
	end
end
