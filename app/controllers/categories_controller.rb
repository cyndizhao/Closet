class CategoriesController < ApplicationController
  def index
    if params[:explore_id].present?
      @explore_id = params[:explore_id]
      @category = Category.find_by_id(@explore_id)
      @posts = @category.posts

    elsif params[:search]
      @search_word = params[:search]
      @search_items = Item.search(params[:search]).order("created_at DESC")
      if @search_items.present?
        @search_posts_ids = Array.new
        @search_items.each do |i|
          @search_posts_ids << (i.post.id)
        end
        @search_posts_ids.uniq!
      end
      render "posts/index", notice:'Search!'
    else
      redirect_to root_path, alert:'Something wrong!'
    end
  end
end
