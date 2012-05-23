class CreatePageParts < ActiveRecord::Migration
  def change
    create_table :page_parts do |t|
      t.references :page
      t.references :part
      t.integer :position, :default => 0
    end
    add_index :page_parts, :page_id
    add_index :page_parts, :part_id
  end
end
