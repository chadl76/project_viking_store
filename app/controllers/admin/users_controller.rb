class Admin::UsersController < ApplicationController
	include Admin::UsersHelper
  def index
  	@user = User.all
  	#@city = User.addresses.first.city


  end

  def show
  	@user = User.find(params[:id])
  	
  	@user_shipping_address = get_address(@user)
  
  end


  def edit
    @user = User.find(params[:id])
    @user.update(user_params)
   # if @user.save
    #  redirect_to(admin_user_path)
    #else
     # render :edit
   # end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save(user_params)
     
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  

end

  




  



private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end