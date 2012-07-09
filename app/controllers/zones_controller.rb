class ZonesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin_user!, :only => [:destroy]
  
end
