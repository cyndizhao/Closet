class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    if cannot? :like, post
      redirect_to post_path(post), alert: 'liking your own post is disgusting'
      return
    end


    like = Like.new(user: current_user, post: post)
    if like.save
      redirect_to post_path(post), notice: 'post liked'
    else
      redirect_to post_path(post), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])
    if cannot? :like, like.post
      redirect_to post_path(like.post), alert: 'Can not Unliking your own post'
      return
    end

    if like.destroy
      redirect_to post_path(like.post), notice:'Un-liked post!'
    else
      redirect_to post_path(like.post), alert: like.errors.full_messages.join(', ')
    end
  end
end
