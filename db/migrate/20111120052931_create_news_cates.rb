class CreateNewsCates < ActiveRecord::Migration
  def change
    create_table :news_cates,:options=>'charset=utf8' do |t|
      t.string :name
    end

    add_index :news_cates, :name, :unique => true
  end
end
