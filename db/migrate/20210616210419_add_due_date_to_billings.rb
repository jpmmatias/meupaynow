class AddDueDateToBillings < ActiveRecord::Migration[6.1]
  def change
    add_column :billings, :due_date, :date
  end
end
