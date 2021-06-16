class AddStatusCodeToBillings < ActiveRecord::Migration[6.1]
  def change
    add_column :billings, :status_code, :integer
  end
end
