class ProductsController < ApplicationController
  before_action :authenticate_customer
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = current_customer.products
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
  
    @product = current_customer.products.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    if @product.destroy
      render json: { message: "Product successfully deleted" }, status: :ok
    else
      render json: { error: "Failed to delete product" }, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      if
        @product = current_customer.products.find(params[:id])
      else
        render json: { error: 'Authentication required' }, status: :unauthorized
      end
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
