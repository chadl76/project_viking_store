class Admin::ProductsController < ApplicationController
  def index
  	@products = Product.all
  end

  def show
  	@product = Product.find(params[:id])

  end

  private

  def total
  	self.all.count
  end
end
