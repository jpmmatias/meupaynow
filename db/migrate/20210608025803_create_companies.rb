class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :corporate_name
      t.integer :cnpj
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
