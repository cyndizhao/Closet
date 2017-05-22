class GendersController < ApplicationController
  def index
    if params[:explore_id].present?
      @explore_id = params[:explore_id]
      id = @explore_id.to_i - 4
      @gender = Gender.find_by_id(id)
      @posts = @gender.posts
    end
  end
end
