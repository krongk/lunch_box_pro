class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.references :address
      t.string :ip

      t.timestamps
    end
    add_index :ip_addresses, :address_id
  end
end
