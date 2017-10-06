class Admin::UsersController < ApplicationController
	include Admin::UsersHelper

  def index
  	@user = User.all
  	
  end

  def show
  	@user = User.find(params[:id])
  	
  	#@user_shipping_address = get_address(@user)
  end


  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]= "User created successfully."
      redirect_to admin_user_path(@user)
    else
      flash.now[:error] = "Failed to create user."
      render :new
    end
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
  end


  
private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :billing_id, :shipping_id)
  end

end