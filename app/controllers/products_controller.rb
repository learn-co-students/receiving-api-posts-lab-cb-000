class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def inventory
    product = Product.find(params[:id])
    render plain: product.inventory > 0 ? true : false
  end

  def description
    product = Product.find(params[:id])
    render plain: product.description
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    # redirect_to products_path
    render json: @product, status: 201 
  end

  # def product_data 
  #   product = Product.find(params[:id])
  #   render json: product.to_json(only: [:name, :price, :description, :inventory])
  # end 

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @product }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price)
  end
end
