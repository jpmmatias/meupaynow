class CompanyPaymentsMethodsController  < ApplicationController
    before_action :authenticate_user!,
    only: %i[index create new ]
    before_action :set_company , only: [:index , :new, :create]
    before_action :only_client_admin , only: [:index, :new, :show]

    def index
		@company_payment_methods = CompanyPaymentMethod.where(company_id: @company.id)
	end

    def new
        @company_payment_method = CompanyPaymentMethod.new
        @payment_methods = PaymentMethod.all
    end

	def create
		@company_payment_method = CompanyPaymentMethod.new(company_payment_method_params) do |a|
			a.company = @company
	  	end

		if @company_payment_method.save
			redirect_to company_company_payments_methods_path(@company), notice: 'Método de Pagamento configurado com sucesso'
		else
			render :new
		end
	end


    private

	def set_company
		@company = Company.find(params[:company_id])
	end

	def only_client_admin
		unless current_user.role == 'client_admin'
			redirect_to dashboard_index_path
		end
	end

	def company_payment_method_params
		params
			.require(:company_payment_method)
			.permit(
				%i[
					bank_account
					ag
					alpha_numeric_code
					payment_method_id
				],
			)
	end
end