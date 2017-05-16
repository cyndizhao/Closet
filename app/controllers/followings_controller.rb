class FollowingsController < ApplicationController
  before_action :authenticate_user!
  def create
    @followed = User.find(params[:user_id])
    @following = Following.new(user_id: @followed.id, follower_id: current_user.id)

    respond_to do |format|
      if @following.save
        format.html {redirect_to user_path(@followed), notice: "You just followed #{@followed.first_name.capitalize}!"}
        format.js {render :render_follow}
      else
        format.html {redirect_to root_path, alert: @following.errors.full_messages.join(', ')}
        format.js {render :render_follow}
      end
    end
  end

  def destroy
    @following = Following.find(params[:id])
    @followed = User.find(@following.user_id)
    user = @following.follower_id

    respond_to do |format|
      if @following.destroy
        format.html {redirect_to user_followers_path(user), notice:'unfollowed'}
        format.js {render :render_follow}
      else
        format.html {redirect_to user_followers_path(user), alert:@following.errors.full_messages.join(', ')}
        format.js {render :render_follow}
      end
    end
  end
end
