class Api::V1::BillingsController < ActionController::API
    before_action :set_product, only: %i[create]

	def create
        @billing = Billing.new(billing_params) do |billing|
            company_payment_method = CompanyPaymentMethod.find(billing.company_payment_method_id)

            billing.product_token = @product.token
            billing.company_token = @product.company.token
            billing.original_value = @product.value
            if company_payment_method.payment_method.payment_type == 'pix'
                billing.value =  @product.value - ((@product.value * @product.discount_pix) / 100 )
            elsif company_payment_method.payment_method.payment_type == 'cartao_de_credito'
                billing.value =  @product.value - ((@product.value * @product.discount_credit) / 100 )
            elsif company_payment_method.payment_method.payment_type == 'boleto'
                billing.value =  @product.value - ((@product.value * @product.discount_boleto )/ 100 )
            end
        end
         if @billing.save
            render json: @billing.as_json,
                       status: :created
            else
                render json: { errors: @customer.errors.full_messages }, status: 400
        end
        end



	private

	rescue_from ActionController::ParameterMissing do |e|
		render json: { error: "Parametrô 'billing' esta faltando" }, status: 412
	end

	def set_product
		@product = Product.find_by(token:params[:product_id])
	end


	def billing_params
        params
        .require(:billing)
        .permit(
            %i[
                credit_card_number
                credit_card_owner_name
                credit_card_verification_code
                customer_id
                company_payment_method_id
                original_value
            ],
        )
	end
end