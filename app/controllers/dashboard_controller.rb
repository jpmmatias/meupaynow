class DashboardController < ApplicationController
    before_action :authenticate_user!
    # before_action :check_if_user_has_company, only: [:index]
    def index
        if current_user.role == 'admin'
            @status_requests = StatusRequest.where(reciever: nil)
            @billings = Billing.all
        else
            @company = current_user.company
            @billings = Billing.where("company_token = ? AND created_at > ?", @company.token, 30.days.ago)
        end
    end



    private

    #  def check_if_user_has_company
    #      if current_user.company.nil? and current_user.role != 'admin'
    #          redirect_to new_company_path
    #      end
    #  end


end