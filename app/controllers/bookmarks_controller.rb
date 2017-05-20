class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    # render render_bookmark_index
    # respond_to do |format|
    #   # format.html {render :index}
    #   format.js {render :render_bookmark_index}
    # end
  end

  def create
    @post = Post.find(params[:post_id])
    if cannot? :bookmark, @post
      redirect_to post_path(@post), alert: 'Can not bookmark you own post'
      return
    end

    @bookmark = Bookmark.new(user: current_user, post: @post)

    respond_to do |format|
      if @bookmark.save
        format.html {redirect_to post_path(@post), notice: 'post bookmark'}
        format.js {render :render_bookmark}
      else
        format.html {redirect_to post_path(@post), alert: @bookmark.errors.full_messages.join(', ')}
        format.js {render :render_bookmark}
      end
    end
  end

  def destroy
    # byebug
    @post = Post.find(params[:post_id])
    @bookmark = Bookmark.find(params[:id])
    if cannot? :bookmark, @post
      redirect_to post_path(@bookmark.post), alert: 'Can not bookmark your own post'
      return
    end
    respond_to do |format|
      if @bookmark.destroy
        format.html {redirect_to post_path(@bookmark.post), notice:'Un-bookmarked post!'}
        format.js {render :render_bookmark}
      else
        format.html {redirect_to post_path(@bookmark.post), alert: @bookmark.errors.full_messages.join(', ')}
        format.js {render :render_bookmark}
      end
    end
  end
end
