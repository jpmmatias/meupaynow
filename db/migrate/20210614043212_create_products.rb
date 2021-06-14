class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :value
      t.float :discount_pix
      t.float :discount_credit
      t.float :discount_boleto

      t.timestamps
    end
  end
end
