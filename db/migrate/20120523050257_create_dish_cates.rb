#encoding: utf-8
class CreateDishCates < ActiveRecord::Migration
  def change
    create_table :dish_cates,:options=>'charset=utf8'  do |t|
      t.string :name, :limit => 64
      t.text :description

      t.timestamps
    end
  end
end
