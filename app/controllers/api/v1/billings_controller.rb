module Api
  module V1
    class BillingsController < ActionController::API
      before_action :set_product, only: %i[create]
      before_action :set_billing, only: %i[show update]

      def index
        @billings = Billing.all
        render json: @billings.as_json(include: :payment_method),
               status: :ok
      end

      def show
        @billing = Billing.find_by(token: params[:id])
        render json: @billing.as_json(include: :payment_method), status: :ok
      end

      def search
        unless params[:due_date].nil?
          @billings = Billing.due_date_after(params[:due_date])
        end
        render json: @billings.as_json(include: :payment_method), status: :ok
      end

      def create
        @billing = Billing.new(billing_params) do |billing|
          company_payment_method = CompanyPaymentMethod.find(billing.company_payment_method_id)
          billing.product_token = @product.token
          billing.company_token = @product.company.token
          billing.original_value = @product.value
          case company_payment_method.payment_method.payment_type
          when 'pix'
            billing.value =  @product.value - ((@product.value * @product.discount_pix) / 100)
          when 'cartao_de_credito'
            billing.value =  @product.value - ((@product.value * @product.discount_credit) / 100)
          when 'boleto'
            billing.value =  @product.value - ((@product.value * @product.discount_boleto) / 100)
          end
        end
        if @billing.save
          render json: @billing.as_json,
                 status: :created
        else
          render json: { errors: @billing.errors.full_messages },
                 status: :bad_request
        end
      end

      def update
        if @billing.nil?
          render json: { error: 'Pagamento não achado' }, status: :not_found
        elsif @billing.update(billing_update_params)
          render json: @billing, status: :no_content
        else
          render json: { errors: @billing.errors.full_messages },
                 status: :internal_server_error
        end
      end

      private

      rescue_from ActionController::ParameterMissing do |_e|
        render json: { error: "Parametrô 'billing' esta faltando" },
               status: :precondition_failed
      end

      def set_product
        @product = Product.find_by(token: params[:product_id])
      end

      def set_billing
        @billing = Billing.find_by(token: params[:id])
      end

      def billing_update_params
        params
          .require(:billing)
          .permit(
            %i[
              status
              status_code
              status_change_date
              autorization_code
            ]
          )
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
              due_date
            ]
          )
      end
    end
  end
end
