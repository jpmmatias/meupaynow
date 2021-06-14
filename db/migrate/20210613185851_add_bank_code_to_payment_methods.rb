class AddBankCodeToPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :bank_code, :integer
  end
end
