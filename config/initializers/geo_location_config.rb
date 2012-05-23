unless GeoLocation == nil
  # Use Hostip (free)
  GeoLocation::use = :hostip
end

# unless GeoLocation == nil
# # Use Max Mind (paid)
# # For more information visit: http://www.maxmind.com/app/city
# GeoLocation::use = :maxmind
# GeoLocation::key = 'YOUR MaxMind.COM LICENSE KEY'
# # This location will be used while you develop rather than hitting the maxmind.com api
# # GeoLocation::dev = 'US,NY,Jamaica,40.676300,-73.775200' # IP: 24.24.24.24
# # Use this IP in development mode (development and testing will give you 127.0.0.1)
# # GeoLocation::dev_ip = '24.24.24.24'
# end

# == HostIP Example

#   location = GeoLocation.find('24.24.24.24') # => {:ip=>"24.24.24.24", :city=>"Liverpool", :region=>"NY", :country=>"United States", :country_code=>"US", :latitude=>"43.1059", :longitude=>"-76.2099", :timezone=>"America/New_York"}
  
#   puts location[:ip] # => 24.24.24.24
#   puts location[:city] # => Liverpool
#   puts location[:region] # => NY
#   puts location[:country] # => United States
#   puts location[:country_code] # => US
#   puts location[:latitude] # => 43.1059
#   puts location[:longitude] # => -76.2099
#   puts location[:timezone] # => America/New_York