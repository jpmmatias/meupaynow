class ClientsController < ApplicationController
  before_action :authenticate_user!,
                only: %i[index show]
  before_action :set_client, only: %i[show request_change_status]
  before_action :only_admin, only: %i[index show request_change_status]

  def index
    @clients = User.where('role=? OR role=?', '0', '5')
  end

  def show; end

  def request_change_status
    request = StatusRequest.new(client: @client, requester: current_user)
    if request.save
      redirect_to client_path(@client),
                  notice: 'Aguardando autorização de outro Admin'
    else
      redirect_to client_path(@client), alert: request.errors.full_messages
    end
  end

  def regenerate_token
    if @company.regenerate_token
      redirect_to company_path(@company),
                  notice: 'Token atualizado com sucesso'
    else
      redirect_to company_path(@company), alert: 'Algum erro aconteceu'
    end
  end

  private

  def set_client
    @client = User.where('id = ? AND (role=? OR role=?)', params[:id], '0',
                         '5').first
  end

  def only_admin
    redirect_to dashboard_index_path unless current_user.role == 'admin'
  end
end
