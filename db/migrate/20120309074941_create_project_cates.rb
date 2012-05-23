class CreateProjectCates < ActiveRecord::Migration
  def change
    create_table :project_cates do |t|
      t.string :name

      t.timestamps
    end
    add_index :project_cates, :name
  end
end
