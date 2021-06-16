class BillingsController < ApplicationController
    before_action :check_admin
    before_action :set_billing, only: [:edit_status, :show, :update]
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


    private

    def check_admin
        if current_user.role != 'admin'
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
            ],
        )

    end



end