class CompaniesController < ApplicationController
    before_action :authenticate_user!,
	              only: %i[ create new ]

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(course_params)
		if @company.save
			current_user.update(company: @company)
			redirect_to dashboard_index_path, notice: 'Empresa configurada com sucesso'
		else
			render :new
		end
    end

	def set_company
		@company = Company.find(params[:id])
	end
	def course_params
		params
			.require(:company)
			.permit(
				%i[
					corporate_name
					cnpj
					email
					address
				],
			)
	end
end