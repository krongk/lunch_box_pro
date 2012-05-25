#encoding: utf-8
class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes,:options=>'charset=utf8'  do |t|
      t.references :dish_cate
      t.string :name, :limit => 128
      t.string :alilas, :limit => 128
      t.string :photo_url, :limit => 64
      t.text :description

      t.timestamps
    end
    add_index :dishes, :dish_cate_id
  end
end
