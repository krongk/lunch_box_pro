class CreateProjectItems < ActiveRecord::Migration
  def change
    create_table :project_items do |t|
      t.references :project_cate
      t.string :tags
      t.string :status
      t.string :title
      t.string :summary
      t.text :content
      t.string :name
      t.string :phone
      t.string :email
      t.string :company
      t.string :city
      t.string :address
      t.string :site_url
      t.integer :sort_id,   :default => 10000
      t.boolean :is_verfied, :default => false
      t.boolean :is_forager, :default => false
      t.string :forager_url
      t.string :note

      t.timestamps
    end
    add_index :project_items, :project_cate_id
    add_index :project_items, :title
  end
end
