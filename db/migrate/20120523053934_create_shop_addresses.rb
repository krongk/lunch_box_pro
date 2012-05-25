#encoding: utf-8
class CreateShopAddresses < ActiveRecord::Migration
  def change
    create_table :shop_addresses,:options=>'charset=utf8'  do |t|
      t.references :shop
      t.references :zone
      t.references :region
      t.references :city
      t.references :district
      t.string :addr, :limit => 64
      t.string :zip, :limit => 16
      t.string :latitude, :limit => 16
      t.string :longitude, :limit => 16
      t.boolean :is_geocoded, :default => false

      t.timestamps
    end
    add_index :shop_addresses, :shop_id
    add_index :shop_addresses, :zone_id
    add_index :shop_addresses, :region_id
    add_index :shop_addresses, :city_id
    add_index :shop_addresses, :district_id
  end
end
