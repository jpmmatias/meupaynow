class CompaniesController < ApplicationController
    before_action :authenticate_user!,
	              only: %i[ create new show ]

	before_action :set_company , only: [:show , :regenerate_token]

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

	def show ;end

	def regenerate_token
		if @company.regenerate_token
           redirect_to company_path(@company), notice: 'Token atualizado com sucesso'
		else
			redirect_to company_path(@company), alert: 'Algum erro aconteceu'
		end
	end

	private

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