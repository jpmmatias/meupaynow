class CreateCompanyPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :company_payment_methods do |t|
      t.string :bank_account
      t.string :ag
      t.string :alpha_numeric_code

      t.timestamps
    end
  end
end
