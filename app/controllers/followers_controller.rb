class FollowersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    # @followings = @user.people_you_follow
    @followings = @user.followed_users
    @followers = @user.followers
    if params[:search]
      @search_word = params[:search]
      @search_persons = User.search_name(params[:search]).order("created_at DESC")
      if @search_persons.present?
        @search_persons_ids = Array.new
        @search_persons.each do |p|
          @search_persons_ids << (p.id)
        end
        @search_persons_ids.uniq!
      end
    end

  end
end
