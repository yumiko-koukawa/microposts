class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show # 追加
   # @user = User.find(params[:id])
    @title = 'Micropost'
    @count = @user.microposts.count
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  def edit
   # @user = User.find(params[:id])
   # render 'edit'
  end

  def update
   # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated your Plofile"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followings
    @title = "followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "followers"
    @user = User.find(params[:id]) 
    @users = @user.follower_users
    render 'show_follow'
  end

  def favorites
    @title = 'Favorites'
    @count = @user.favorite_microposts.count
   #@microposts = @user.favorite_microposts(created_at: :desc).page(params[:page]).per(3)
   @microposts = @user.favorite_microposts.order(created_at: :desc).page(params[:page]).per(3)             
    render 'show'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location)
  end

  def set_params
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_path if @user != current_user
  end
end
