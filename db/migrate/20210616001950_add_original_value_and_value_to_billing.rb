class AddOriginalValueAndValueToBilling < ActiveRecord::Migration[6.1]
  def change
    add_column :billings, :original_value, :decimal
    add_column :billings, :value, :decimal
  end
end
