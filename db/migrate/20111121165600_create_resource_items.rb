class CreateResourceItems < ActiveRecord::Migration
  def change
    create_table :resource_items,:options=>'charset=utf8' do |t|
      t.string :resource_type
      t.references :resource_cate
      t.string :resource_name
      t.string :resource_path
      t.string :resource_note

      t.timestamps
    end
    add_index :resource_items, :resource_cate_id
    add_index :resource_items, :resource_type
  end
end
