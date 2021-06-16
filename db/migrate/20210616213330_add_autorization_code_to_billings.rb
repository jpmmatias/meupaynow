class AddAutorizationCodeToBillings < ActiveRecord::Migration[6.1]
  def change
    add_column :billings, :autorization_code, :string
  end
end
