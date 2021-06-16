class AddAprovedDateToBillings < ActiveRecord::Migration[6.1]
  def change
    add_column :billings, :aproved_date, :date
  end
end
