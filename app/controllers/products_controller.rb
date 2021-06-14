class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:index, :new, :create]
  before_action :set_product, only: [:show]
  before_action :only_company_member , only: [:index , :new, :create]

  def index
    @products = @company.products
  end

  def show

  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params) do |a|
			a.company = @company
	  end

    if @product.save
      redirect_to company_product_path(@company, @product), notice: 'Produto criado com sucesso'
    else
      render :new
    end
  end


  private

  def set_company
    @company = Company.find_by(id: params[:company_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def only_company_member
    unless current_user.company == Company.find_by(id: params[:company_id])
        redirect_to root_path
    end
  end

	def product_params
		params
			.require(:product)
			.permit(
				%i[
					name
					value
					discount_pix
					discount_credit
          discount_boleto
				],
			)
	end



end