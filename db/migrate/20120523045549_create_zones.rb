#encoding: utf-8
class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones,:options=>'charset=utf8'  do |t|
      t.string :name, :limit => 64
      t.string :alias, :limit => 64
      t.string :addr, :limit => 128
      t.string :latitude, :limit => 16
      t.string :longitude, :limit => 16
      t.decimal :range

      t.timestamps
    end
  end
end
