#encoding: utf-8
class CreateShopDishes < ActiveRecord::Migration
  def change
    create_table :shop_dishes,:options=>'charset=utf8'  do |t|
      t.references :shop
      t.references :dish
      t.string :price, :limit => 16
      t.boolean :is_hot, :default => false
      t.boolean :is_discount, :default => false
      t.float :discount_value
      t.text :description
      t.string :note, :limit => 512

      t.timestamps
    end
    add_index :shop_dishes, :shop_id
    add_index :shop_dishes, :dish_id
  end
end
