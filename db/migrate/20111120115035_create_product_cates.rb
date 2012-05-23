class CreateProductCates < ActiveRecord::Migration
  def change
    create_table :product_cates,:options=>'charset=utf8' do |t|
      t.string :name
    end
  end
end
