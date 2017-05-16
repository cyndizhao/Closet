class CategoriesController < ApplicationController
  def index
    @search_id = params[:search_id]
    @category = Category.find_by_id(@search_id)
    @posts = @category.posts
  end
end
