class StaticPagesController < ApplicationController
  
  def home
  	@feed_items = Post.all
  end

  def about
  end
end
