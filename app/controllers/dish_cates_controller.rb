class DishCatesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :only => [:destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  
end
