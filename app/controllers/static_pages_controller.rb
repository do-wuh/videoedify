class StaticPagesController < ApplicationController  
  def index
    @courses = Course.all
  end

  def privacy    
  end
end
