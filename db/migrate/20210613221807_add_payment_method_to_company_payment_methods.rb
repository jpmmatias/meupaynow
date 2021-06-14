class AddPaymentMethodToCompanyPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    add_reference :company_payment_methods, :payment_method, null: false, foreign_key: true
  end
end
