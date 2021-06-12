class CreateStatusRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :status_requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :reciever, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
