class SearchController < ApplicationController
  
  def search_index
    search_string = "*" + params[:search] + "*"
    @pages = Page.search search_string
    @posts = Post.search search_string
  end
  
end
