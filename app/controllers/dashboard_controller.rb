class DashboardController < ApplicationController
    before_action :authenticate_user!
    # before_action :check_if_user_has_company, only: [:index]
    def index

    end

    private

    #  def check_if_user_has_company
    #      if current_user.company.nil? and current_user.role != 'admin'
    #          redirect_to new_company_path
    #      end
    #  end


end