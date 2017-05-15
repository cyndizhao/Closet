class GendersController < ApplicationController
  def index
    @search_id = params[:search_id]
    id = @search_id.to_i - 4
    @gender = Gender.find_by_id(id)
    @posts = @gender.posts
  end
end
