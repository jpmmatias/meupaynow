class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'admin'
      @status_requests = StatusRequest.where(reciever: nil)
      @billings = Billing.all
    else
      @company = current_user.company
      @billings = Billing.where('company_token = ? AND created_at > ?',
                                @company.token, 30.days.ago)
    end
  end
end
