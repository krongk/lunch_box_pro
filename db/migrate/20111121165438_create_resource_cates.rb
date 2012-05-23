class CreateResourceCates < ActiveRecord::Migration
  def change
    create_table :resource_cates,:options=>'charset=utf8' do |t|
      t.string :name
    end
  end
end
