class CreateShopDishVersions < ActiveRecord::Migration
  def change
    create_table :shop_dish_versions do |t|
      t.references :shop
      t.references :dish
      t.string :price
      t.boolean :is_hot
      t.boolean :is_discount
      t.string :discount_value
      t.text :description
      t.boolean :is_merged, :default => false

      t.timestamps
    end
    add_index :shop_dish_versions, :shop_id
    add_index :shop_dish_versions, :dish_id
  end
end
