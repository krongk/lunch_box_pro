class CreateProductItems < ActiveRecord::Migration
  def change
    create_table :product_items,:options=>'charset=utf8' do |t|
      t.references :product_cate
      t.string :title
      t.text :description
      t.decimal :price, :precision => 10, :scale => 2
      t.string :image_path
      t.boolean :is_visible, :default => true
      
      t.timestamps
    end
    add_index :product_items, :product_cate_id
  end
end
