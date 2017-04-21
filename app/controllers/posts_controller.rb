class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :get_post, only:[:show, :update, :edit, :destroy]
  before_action :post_params, only:[:update, :create]

  def index
    #Most_recent
    @last_post = Post.last(3)
    #Trending
    @most_liked = Post.left_joins(:likes).group(:id).order("COUNT(post_id) DESC").limit(3)
  end

  # def new
  #   @post = Post.new
  # end
  #
  # def create
  #   # post_params = params.require(:post).permit([:title, :body, :category_id])
  #   @post = Post.new (post_params)
  #   @post.user = current_user
  #   if @post.save
  #     redirect_to post_path({id: @post.id })
  #   else
  #     render :new
  #   end
  # end
  #
  # def show
  #   @number = 2
  #   # @post = Post.find(params[:id])
  #   @comment = Comment.new
  #   @comments = @post.comments
  #   # try to limit number of the displaying comments
  #   if !(@post.likes.find_by_user_id(current_user))
  #     @liked_by_currentuser = false
  #   else
  #     @liked_by_currentuser = true
  #
  #   end
  #   @like = Like.new
  #
  # end
  #
  # def destroy
  #   # @post = Post.find params[:id]
  #   if !can? :destroy, @post
  #     redirect_to root_path, alert:'Access denied!'
  #   else
  #     @post.destroy
  #     redirect_to posts_path, notice:'Post Deleted!'
  #   end
  # end
  #
  # def edit
  #   # @post = Post.find(params[:id])
  #   redirect_to root_path, alert:'Access denied!' unless can? :edit, @post
  #
  # end
  #
  # def update
  #
  #   # @post = Post.find(params[:id])
  #   # post_params = params.require(:post).permit([:title, :body, :category_id])
  #   if !can? :edit, @post
  #     redirect_to root_path, alert:'Access denied!'
  #   elsif @post.update(post_params)
  #     flash[:notice] = "Post Updated"
  #     redirect_to post_path(@post)
  #   else
  #     render :edit
  #   end
  # end
  #
  # private
  # def get_post
  #   @post = Post.find(params[:id])
  # end
  #
  # def post_params
  #   params.require(:post).permit([:title, :body, :category_id])
  # end

end
