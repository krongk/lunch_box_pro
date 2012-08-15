class CreateShopVersions < ActiveRecord::Migration
  def change
    create_table :shop_versions do |t|
      t.references :shop
      t.string :contacter_name
      t.string :tel_phone
      t.string :mobile_phone
      t.string :email
      t.string :qq
      t.string :name
      t.text :description
      t.text :shop_note
      t.string :biz_time
      t.string :photo_url
      t.boolean :has_out_food, :default => false
      t.boolean :has_out_people, :default => true
      t.string :start_price
      t.string :outer_time
      t.references :district
      t.string :addr
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :is_checked, :default => false
      t.boolean :is_merged, :default => false
      t.version :integer, :default => 1
      t.timestamps
    end
    add_index :shop_versions, :shop_id
    add_index :shop_versions, :district_id
  end
end
