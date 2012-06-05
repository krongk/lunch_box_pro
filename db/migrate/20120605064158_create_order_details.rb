class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.references :order
      t.references :shop_dish
      t.integer :amount
      t.decimal :discount, :precision => 8, :scale => 2
      t.decimal :total_price, :precision => 8, :scale => 2
      t.string :admin_note

      t.timestamps
    end
    add_index :order_details, :order_id
    add_index :order_details, :shop_dish_id
  end
end
