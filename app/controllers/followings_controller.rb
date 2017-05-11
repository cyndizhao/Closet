class FollowingsController < ApplicationController
  before_action :authenticate_user!
  def create
    followed = User.find(params[:user_id])
    following = Following.new(user_id: followed.id, follower_id: current_user.id)

    if following.save
      redirect_to user_path(followed), notice: "You just followed #{followed.first_name.capitalize}!"
    else
      redirect_to root_path, alert: following.errors.full_messages.join(', ')
    end
  end

  def destroy
    byebug
    following = Following.find(params[:id])
    user = following.follower_id
    if following.destroy
      redirect_to user_followers_path(user), notice:'unfollowed'
    else
      redirect_to user_followers_path(user), alert:following.errors.full_messages.join(', ')
    end
  end
  # def destroy
  #   like = Like.find(params[:id])
  #
  #
  #   if like.destroy
  #     redirect_to question_path(like.question), notice:'Un-liked question!'
  #   else
  #     redirect_to question_path(like.question), alert: like.errors.full_messages.join(', ')
  #   end
  # end
end
