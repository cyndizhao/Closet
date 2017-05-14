class FollowersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    # @followings = @user.people_you_follow
    @followings = @user.followed_users
    @followers = @user.followers
  end
end