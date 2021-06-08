class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def after_sign_in_path_for(resource)
		dashboard_index_path
	  end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name , :surname])
		devise_parameter_sanitizer.permit(:account_update, keys: [:company , :company_id])
	end
end
