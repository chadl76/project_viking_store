class Admin::ProductsController < ApplicationController
  def index
  	@products = Product.all
  end

  def show
  	@product = Product.find(params[:id])

  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(whitelisted_product_params)
    if @product.save
      flash[:success] = "New product created!"
      redirect_to admin_products_path
    else
      flash.now[:error] = "Failed to create product."
      redirect_to 'new'
    end
  end

  def update
    if @product.update_attributes(whitelisted_product_params)
      flash[:success] = "Product updated successfully!"
      redirect_to admin_products_path
    else
      flash.now[:error] = "Failed to update product"
      redirect_to 'new'
    end
  end

  private

  def total
  	self.all.count
  end

  def whitelisted_product_params
    params.require(:product).permit(:name, :price, :sku, :category_id)
  end
end
