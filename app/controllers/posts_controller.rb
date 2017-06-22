class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :get_post, only:[:show, :update, :edit, :destroy]
  before_action :post_params, only:[:update, :create]
  before_action :user_published?, except:[:index, :show]

  def index
    @users = User.all
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
    if user_signed_in? && current_user.is_public
      list_of_posts = []
      current_user.people_you_follow.each do |u|
        u.posts.each do |post|
          list_of_posts.push(post)
        end
      end
      @friends_new_posts = list_of_posts.sort {|a, b| b[:created_at] <=> a[:created_at] }
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
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      raw_items = JSON.parse(params[:items_json])
      raw_items.each do |item|
        item['brand_id'] = Brand.find_by_name(item['brand']).id
        item.delete('brand')
        @post.items.create(item)
      end
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


  private
  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit([:description, :picture, :category_id, :brand_id, :gender_id])
  end

end
