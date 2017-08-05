class DashboardController < ApplicationController

	def index
		@user_total = User.all.count
	end


end
