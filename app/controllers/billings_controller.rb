class BillingsController < ApplicationController
    before_action :check_admin
    def index
        @billings = Billing.all
    end

    private

    def check_admin
        if current_user.role != 'admin'
            redirect_to root_path
        end
    end

end