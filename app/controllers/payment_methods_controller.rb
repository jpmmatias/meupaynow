class  PaymentMethodsController < ApplicationController
    def index
        @payment_methods = PaymentMethod.all
    end

    def new
        @payment_method = PaymentMethod.new
    end

    def create
        @payment_method = PaymentMethod.new(payment_method_params)
        if @payment_method.save
            redirect_to payment_methods_path
        else
            render :new
        end


    end

    def payment_method_params
		params
			.require(:payment_method)
			.permit(
				%i[
					name
					payment_type
					tax
					active
					icon
				],
			)
	end


end