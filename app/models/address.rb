#encoding: utf-8
class Address < ActiveRecord::Base
  belongs_to :region
  belongs_to :city
  belongs_to :district
  belongs_to :zone
  has_one :ip_address

  #when add a new address on admin
  geocoded_by :full_addr
  after_validation :geocode
  before_update :translate

  def translate
    en_addr = Pinyin.t addr
    en_combined_addr = en_addr.gsub(/[^0-9a-z]/i, '')
  end

  #通过搜索参数获取地址的point, 通过point就可以得到所有附件餐厅
  def self.get(addr)

    a = find_by_addr(addr)
    a ||= find_by_full_addr(addr)
    a ||= self.where(["addr like ?", "%#{addr}%"]).try(:first)
    a ||= self.where(["full_addr like ?", "%#{addr}%"]).try(:first)

    if a.nil?
      point = nil
      begin
        point = Geocoder.coordinates(addr)
      rescue 
      end
      
      unless point.nil?
        a = create!(
          :addr => addr,
          :region_id => 23,
          :city_id => 234,
          :full_addr => "成都市#{addr}",
          :en_addr => Pinyin.t(addr)
        )
      end
    end
    a
  end

end

=begin
after_save runs both on create and update, but always after the more specific callbacks after_create and after_update, no matter the order in which the macro calls were executed.
10.1 Creating an Object
before_validation
after_validation
before_save
around_save
before_create
around_create
after_create
after_save

10.2 Updating an Object
before_validation
after_validation
before_save
around_save
before_update
around_update
after_update
after_save

10.3 Destroying an Object
before_destroy
around_destroy
after_destroy
=end
