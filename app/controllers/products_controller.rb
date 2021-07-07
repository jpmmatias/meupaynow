class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[index new create update edit]
  before_action :set_product, only: %i[show update edit]
  before_action :only_company_member,
                only: %i[index new create update edit]

  def index
    @products = @company.products
  end

  def show
    @product_versions = @product.versions
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params) do |a|
      a.company = @company
    end

    if @product.save
      redirect_to company_product_path(@company, @product),
                  notice: 'Produto criado com sucesso'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to company_product_path(@company, @product),
                  notice: 'Produto atualizado com sucesso'
    else
      render :new
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def only_company_member
    unless current_user.company == Company.friendly.find(params[:company_id])
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
        ]
      )
  end
end
