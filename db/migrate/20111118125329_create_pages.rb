class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages  do |t|
      t.string :title
      t.text :body
      t.integer :parent_id, :default => 0
      t.integer :position, :default => 0
      t.string :path_name
      t.string :meta_keywords
      t.string :meta_description
      t.string :menu_match
      t.integer :show_in_menu, :default => 1 #1:yes 0:no
      t.integer :deletable, :default => 1 #1:yes 0:no

      t.timestamps
    end
    add_index :pages, :parent_id
    add_index :pages, :title
    add_index :pages, :path_name, :unique => true
  end
end
