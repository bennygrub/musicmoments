class PageController < ApplicationController
  before_filter :home_to_profile, :only => [:home]

  def home
  	@title = "Music Moments Home Page Bros"
  end

  def about
  end

  def contact
  end

  private
    
    def home_to_profile
      redirect_to current_user if current_user
    end

end
