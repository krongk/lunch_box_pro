class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :shop
      t.references :user
      t.float :total_price, :precision => 8, :scale => 2
      t.string :phone
      t.string :addr
      t.string :user_note
      t.datetime :require_deliver_time
      t.integer :status, :default => 0
      t.string :admin_note

      t.timestamps
    end
    add_index :orders, :shop_id
    #add_index :orders, :user_id
  end
end
