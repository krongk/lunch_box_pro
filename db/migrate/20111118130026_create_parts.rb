class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts, :options=>'charset=utf8' do |t|
      t.string :title
      t.text :body
    end
    add_index :parts, :title, :unique => true
  end
end
