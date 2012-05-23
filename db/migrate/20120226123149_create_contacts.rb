#encoding: utf-8
class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :qq
      t.string :company
      t.string :address
      t.string :title
      t.text :message
      t.string :cate,   :default => '联系我们'
      t.text :note
      t.boolean :is_verfied, :default => false
      t.string :verfied_by
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
  end
end
