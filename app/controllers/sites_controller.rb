class SitesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
end
