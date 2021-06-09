class ReanemTypeToPaymentType < ActiveRecord::Migration[6.1]
  def change
    rename_column :payment_methods, :type, :payment_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
