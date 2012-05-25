class WelcomeController < ApplicationController
  def search
    @shop = Shop.new
    render 'search', :layout => nil
  end

  def index
    render :text => params
  end

  def help
  end

  def about
  end

  def agreement
  end

end
