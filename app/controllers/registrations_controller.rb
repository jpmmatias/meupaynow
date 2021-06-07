class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end

    def create
        build_resource(sign_up_params)

        if resource.email.include? "@paynow.com.br"
            resource.role = 10
        end

        resource.save
        yield resource if block_given?
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message! :notice, :signed_up
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
          else
            set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource
        end
    end

    def update
      super
    end

    protected

    def after_sign_in_path_for(resource)
        dashboard_index_path
    end

  end