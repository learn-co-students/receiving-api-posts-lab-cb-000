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
    product = Product.create(product_params)
    # render json: product.to_json (implicitly sets status code: 200) (which would work)
    render json: product.to_json, status: 201  # Better!
    # AJAX .done() won't accept a status code 302
    # It will only accept a code in the 200s:
      # 200 (the default for render) means OK
      # 201 means a resource was created
  end

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
