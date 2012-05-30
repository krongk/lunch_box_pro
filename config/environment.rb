# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RailsOnWeb::Application.initialize!

#
addr_hash = {}
Address.all.each  do |a|
  addr_hash[a.addr] = "#{a.en_addr.to_s.gsub(/ /, '')} #{a.en_addr} #{a.full_addr}"
end
RailsOnWeb::Application.config.address_token = addr_hash