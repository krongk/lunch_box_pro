#encoding: utf-8
class Address < ActiveRecord::Base
  belongs_to :region
  belongs_to :city
  belongs_to :district
  belongs_to :zone

  geocoded_by :full_addr
  after_validation :geocode

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
        puts '----------------------------'
        puts a
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
