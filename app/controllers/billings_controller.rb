class BillingsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :edit_status, :update, :edit_status, :show, :update, :last_90_days, :history]
    before_action :check_admin, only: [:index, :show, :edit_status, :update]
    before_action :set_billing, only: [:edit_status, :show, :update, :recieve]
    before_action :check_company_client, only: [:last_90_days, :history]

    def index
        @billings = Billing.all
    end

    def show
        @billing_versions = @billing.versions
    end


    def edit_status ;end


    def update
        if @billing.update(billings_param)
            redirect_to billings_path, notice: 'Status Aletrado com Sucesso'
        else
            redirect_to billings_path, alert: 'Algum erro aconteceu'
        end
    end

    def recieve
        @billing = Billing.find(params[:id])
        unless @billing.status = 'approved'
            redirect_to root_path
        end
    end

    def history
        @company = current_user.company
        @billings = Billing.where("company_token = ? ", @company.token)
    end

    def last_90_days
        @company = current_user.company
        @billings = Billing.where("company_token = ? AND created_at > ?", @company.token, 90.days.ago)
    end

    private

    def check_admin
        if current_user.role != 'admin'
            redirect_to root_path
        end
    end

    def check_company_client
        if current_user.role == 'admin'
            redirect_to root_path
        end
        unless current_user.company == Company.friendly.find(params[:id])
            redirect_to root_path
        end
    end


    def set_billing
        @billing = Billing.friendly.find(params[:id])
    end

    def billings_param
        params
        .require(:billing)
        .permit(
            %i[
                status
                status_code
                status_change_date
                autorization_code
            ],
        )

    end



end