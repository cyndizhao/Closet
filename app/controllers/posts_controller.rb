class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :get_post, only:[:show, :update, :edit, :destroy]
  before_action :post_params, only:[:update, :create]

  def index
    if params[:search]
      @search_word = params[:search]
      @search_items = Item.search(params[:search]).order("created_at DESC")
      if @search_items.present?
        @search_posts_ids = Array.new
        @search_items.each do |i|
          @search_posts_ids << (i.post.id)
        end
        @search_posts_ids.uniq!
      end
    end

    #New posts from friend
    if user_signed_in?
      list_of_posts = []
      current_user.people_you_follow.each do |u|
        u.posts.each do |post|
          list_of_posts.push(post)
        end
      end
      @friends_new_posts = list_of_posts.sort {|a, b| b[:created_at] <=> a[:created_at] }
      #TODO get the first 8 of array
    end
    #Most_recent
    @last_posts = Post.last(8)
    #Trending
    @most_liked_posts = Post.left_joins(:likes).group(:id).order("COUNT(post_id) DESC").limit(8)
  end

  def new
    @post = Post.new
  end

  def create
    #params.require(:post).permit([:description, :picture, :category_id])
    # byebug
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      raw_items = JSON.parse(params[:items_json])
      raw_items.each do |item|
        item['brand_id'] = Brand.find_by_name(item['brand']).id
        item.delete('brand')
        @post.items.create(item)
      end
      # redirect_to user_path(current_user)
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
    end
  end

  def destroy
    user = @post.user
    if !can? :destroy, @post
      redirect_to user_path(user), alert:'Access denied!'
    else
      @post.destroy
      redirect_to user_path(user), notice:'Post Deleted!'
    end
  end
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
  private
  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit([:description, :picture, :category_id, :brand_id, :gender_id])
  end

end
