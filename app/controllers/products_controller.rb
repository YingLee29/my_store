# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    ActiveRecord::Base.transaction do
      @product = Product.new(product_params)

      if @product.save
        redirect_to products_path
      else
        raise ActiveRecord::Rollback
      end
    end

  rescue StandardError => e
    flash[:error] = "Something went wrong: #{e.message}"
    render 'new'
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @product = Product.find(params[:id])

      if @product.update(product_params)
        redirect_to products_path
      else
        raise ActiveRecord::Rollback
      end
    end

  rescue StandardError => e
    flash[:error] = "Something went wrong: #{e.message}"
    render 'edit'
  end

  def destroy
    if @product.destroy
      flash[:success] = "successfully deleted"
      redirect_to products_path
    else
      flash[:error] = "Something went wrong"
      redirect_to products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :category, :price,
                                    :old_price, :stock_status, :new_status,
                                    :screen_size, :refresh_rate, :ram,
                                    :storage, :installment, :brand)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
