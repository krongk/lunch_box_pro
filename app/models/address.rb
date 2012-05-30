#encoding: utf-8
class Address < ActiveRecord::Base
  belongs_to :region
  belongs_to :city
  belongs_to :district
  belongs_to :zone

  geocoded_by :full_addr
  after_validation :geocode

  #定义地址检索索引，加速auto-complete
  def self.address_hash
    @@addr_hash ||= {}
    self.all.each  do |a|
      @@addr_hash[a.addr] = "#{a.en_addr.to_s.gsub(/ /, '')} #{a.en_addr} #{a.full_addr}"
    end
    @@addr_hash
  end
  #通过搜索参数获取地址的point, 通过point就可以得到所有附件餐厅
  def self.get(addr)

    a = find_by_addr(addr)
    a ||= find_by_full_addr(addr)
    a ||= self.where(["addr like ?", "%#{addr}%"]).try(:first)

    if a.nil?
      point = []
      begin
        point = Geocoder.coordinates(addr)
      rescue 
      end
      
      unless point.nil?
        a = self.where(["latitude like ? AND longitude like ?", "#{point[0].to_s[0..6]}%", "#{point[1].to_s[0..7]}%"]).try(:first)
        unless a
          a = create!(
            :addr => addr,
            :region_id => 23,
            :city_id => 234,
            :full_addr => "成都市#{addr}"
          )
        end
      end
    end
    a
  end

end