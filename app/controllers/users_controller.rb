class UsersController < ApplicationController
  before_action :get_user, only:[:show, :edit, :update]
  before_action :authenticate_user!, only:[:update, :edit, :show]
  before_action :user_published?, except:[:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing in"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user_id = params[:id]
    @user = User.find_by_id(@user_id)
    @posts = @user.posts
  end

  def edit
    if @user == current_user
      render :edit, notice: "edited successfully"
    else
      redirect_to root_path, alert: "can not edit other's profile"
    end
  end

  def update
    if @user == current_user
      if @user.update(params.require(:user).permit([:first_name, :last_name, :company_name, :email, :description, :selfie]))
        flash[:notice] = "User Infomation Updated"
        redirect_to user_path(current_user)
      else
        render :edit
      end
    else
      redirect_to root_path, alert: "can not update other's profile"
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:first_name, :last_name, :email, :description, :password, :password_confirmation, :selfie, :business_user, :company_name])
  end
end
