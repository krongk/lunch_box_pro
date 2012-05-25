#encoding: utf-8
class CreateShopContacts < ActiveRecord::Migration
  def change
    create_table :shop_contacts,:options=>'charset=utf8'  do |t|
      t.references :shop
      t.string :contacter_name, :limit => 32
      t.string :tel_phone, :limit      => 16
      t.string :mobile_phone, :limit   => 16
      t.string :qq, :limit             => 16
      t.string :email, :limit          => 16
      t.string :other, :limit          => 512
      t.string :jiaotong, :limit       => 128
      t.string :website, :limit        => 32
      t.string :weibo, :limit          => 32

      t.timestamps
    end
    add_index :shop_contacts, :shop_id
  end
end
