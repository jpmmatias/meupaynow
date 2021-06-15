class CreateFinalCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :cpf
      t.string :token
      t.string :slug

      t.timestamps
    end
    add_index :customers, :token, unique: true
    add_index :customers, :slug, unique: true
  end
end
