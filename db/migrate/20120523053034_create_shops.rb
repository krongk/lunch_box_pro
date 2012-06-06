#encoding: utf-8
class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops,:options=>'charset=utf8'  do |t|
      t.string :name, :limit              => 128
      t.text :description
      t.string :avg, :limit               => 64
      t.string :biz_time, :limit          => 64
      t.float :start_price
      t.float :outer_price
      t.string :shihe, :limit              => 255
      t.string :sheshi, :limit              => 255
      t.float :rate
      t.float :score
      t.float :score_kouwei
      t.float :score_sudu
      t.float :score_fuwu
      t.string :photo_url, :limit         => 128
      t.string :shop_cate, :limit         => 128
      t.string :tags
      t.string :secret, :limit            => 32
      t.boolean :has_out_food, :default   => false
      t.boolean :has_out_people, :default => false
      t.boolean :is_new_added, :default   => false
      t.boolean :is_hot, :default         => false
      t.date :hot_unitl
      t.boolean :is_discount, :default    => false
      t.float :discount_value
      t.integer :updated_by, :default     => 0
      t.boolean :is_contacted, :default   => false
      t.boolean :is_dealed, :default      => false
      t.string :original_source, :limit   => 32
      t.string :original_url, :limit      => 128

      t.timestamps
    end
    add_index :shops, :name
    add_index :shops, :has_out_food
    add_index :shops, :has_out_people
    add_index :shops, :is_new_added
    add_index :shops, :is_hot
    add_index :shops, :is_contacted
    add_index :shops, :is_discount
    add_index :shops, :is_dealed
  end
end
