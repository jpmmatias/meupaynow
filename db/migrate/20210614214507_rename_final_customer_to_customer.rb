class RenameFinalCustomerToCustomer < ActiveRecord::Migration[6.1]
  def change
    def self.up
      rename_table :final_customers, :customers
    end

    def self.down
      rename_table :final_customers, :customers
    end
  end
end
