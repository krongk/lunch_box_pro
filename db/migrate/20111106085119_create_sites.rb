class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites  do |t|
      t.string :name
      t.string :value
    end
    add_index :sites, :name, :unique => true
  end
end

# below failed on Sqlite3
#  create_table :sites,:options=>'charset=utf8'  do |t|