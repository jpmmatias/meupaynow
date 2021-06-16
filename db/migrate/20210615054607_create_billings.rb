class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.string :company_token
      t.string :product_token
      t.references :company_payment_method, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :credit_card_number
      t.string :credit_card_owner_name
      t.integer :credit_card_verification_code
      t.string :boleto_address
      t.integer :status, null: false, default: 0
      t.string :token, unique: true
      t.string :slug, unique: true

      t.timestamps
    end
  end
end
