class BillingsFixAprovedDate < ActiveRecord::Migration[6.1]
  def change
    rename_column :billings, :aproved_date, :status_change_date
  end
end
