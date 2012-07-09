#encoding: utf-8
class Address < ActiveRecord::Base
  belongs_to :region
  belongs_to :city
  belongs_to :district
  belongs_to :zone
  has_one :ip_address

  #geocoded_by :full_addr
  #after_validation :geocode

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
