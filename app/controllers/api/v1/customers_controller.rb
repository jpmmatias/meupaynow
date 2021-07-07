module Api
  module V1
    class CustomersController < ActionController::API
      before_action :set_customer, only: %i[edit update show destory]
      before_action :set_company, only: %i[index create]
      def index
        @customers = @company.customers
        render json:
            @customers.as_json(
              excpet: %i[id created_at updated_at]
            ),
               status: :ok
      end

      def show
        if @customer.nil?
          render json: { error: 'Cliente não existente' }, status: :not_found
        else
          render json:
              @customer.as_json(
                excpet: %i[id created_at updated_at]
              ),
                 status: :ok
        end
      end

      def create
        if Customer.where('name = ? AND cpf = ?', params[:name],
                          params[:cpf]).empty?
          @customer = Customer.new(customer_params)
          if @customer.save
            Subscription.create!(company: @company,
                                 customer: @customer)
            render json: { response: 'Cliente Adicionado a empresa com Sucesso' },
                   status: :created
          else
            render json: { errors: @customer.errors.full_messages },
                   status: :bad_request
          end
        else
          customer = Customer.where('name = ? AND cpf = ?', params[:name],
                                    params[:cpf]).first
          Subscription.new(company: @company, customer: customer)
          if Subscription.save
            render json: { response: 'Cliente Adicionado a empresa com Sucesso' },
                   status: :created
          end

        end
      end

      private

      rescue_from ActionController::ParameterMissing do |_e|
        render json: { error: "Param 'customer' esta faltando" },
               status: :precondition_failed
      end

      def set_customer
        @customer = Customer.friendly.find(params[:id])
      end

      def set_company
        @company = Company.friendly.find(params[:company_id])
      end

      def customer_params
        params
          .require(:customer)
          .permit(
            %i[
              name
              cpf
            ]
          )
      end
    end
  end
end
