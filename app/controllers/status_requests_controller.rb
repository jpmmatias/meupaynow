class  StatusRequestsController < ApplicationController
    before_action :authenticate_user!,
    only: %i[ change ]
    before_action :set_request, only: [:change]
	before_action :only_admin , only: [:change]

    def change
        client = @request.client
        if client.update(active: !client.active)
            @request.update!(reciever: current_user)
            redirect_to dashboard_index_path, notice: 'Cliente desativado com sucesso'
        else
            redirect_to dashboard_index_path, alert: 'Algum erro aconteceu'
        end
    end

    private

	def set_request
		@request = StatusRequest.find(params[:id])
	end

	def only_admin
		unless current_user.role == 'admin'
			redirect_to dashboard_index_path
		end
	end

end