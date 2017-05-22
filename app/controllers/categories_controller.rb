class CategoriesController < ApplicationController
  def index
    if params[:explore_id].present?
      @explore_id = params[:explore_id]
      @category = Category.find_by_id(@explore_id)
      @posts = @category.posts
    end
  end
end
