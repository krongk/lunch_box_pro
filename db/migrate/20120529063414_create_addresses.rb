class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :region
      t.references :city
      t.references :district
      t.references :zone
      t.string :addr
      t.string :full_addr
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :addresses, :region_id
    add_index :addresses, :city_id
    add_index :addresses, :district_id
    add_index :addresses, :zone_id
  end
end
