class WelcomeController < ApplicationController
  def search
    @shop = Shop.new
    render 'search', :layout => nil
  end

  def index
    if cookies[:addr]
      render :text => cookies[:addr]
    else
      redirect_to new_address_path
    end
  end

  def help
  end

  def about
  end

  def agreement
  end

end
