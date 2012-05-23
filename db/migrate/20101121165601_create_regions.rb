#encoding: utf-8
class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions, :options=>'charset=utf8' do |t|
      t.string :name
	  t.string :en_name
    end

    Region.create(:name => '北京')
    Region.create(:name => '天津')
    Region.create(:name => '河北')
    Region.create(:name => '山西')
    Region.create(:name => '内蒙古')
    Region.create(:name => '辽宁')
    Region.create(:name => '吉林')
    Region.create(:name => '黑龙江')
    Region.create(:name => '上海')
    Region.create(:name => '江苏')
    Region.create(:name => '浙江')
    Region.create(:name => '安徽')
    Region.create(:name => '福建')
    Region.create(:name => '江西')
    Region.create(:name => '山东')
    Region.create(:name => '河南')
    Region.create(:name => '湖北')
    Region.create(:name => '湖南')
    Region.create(:name => '广东')
    Region.create(:name => '广西')
    Region.create(:name => '海南')
    Region.create(:name => '重庆')
    Region.create(:name => '四川')
    Region.create(:name => '贵州')
    Region.create(:name => '云南')
    Region.create(:name => '西藏')
    Region.create(:name => '陕西')
    Region.create(:name => '甘肃')
    Region.create(:name => '青海')
    Region.create(:name => '宁夏')
    Region.create(:name => '新疆')
  end

  def self.down
    drop_table :regions
  end
end
