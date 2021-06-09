class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.integer :type, default: 0
      t.string :name
      t.decimal :tax

      t.timestamps
    end
  end
end
