class UsersController < ApplicationController
  before_action :require_user_logged_in,only: [:index,:show,:followings,:followers]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user_default = "default_icon.jpg"
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to :root
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  @user = User.find(params[:id])
  end
  
  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:success] = 'ユーザーは正常に更新されました'
    redirect_to @user
    else
    flash.now[:danger] = 'ユーザーは更新されませんでした'
    render :edit
    end
  end
  
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def contributor_rank
  @user = current_user
  
  # ユーザーの全投稿に対するいいね数ランキング
  recipe_like_count = {}
  User.all.each do |user|
    recipe_like_count.store(user, Favorite.where(recipe_id: Recipe.where(user_id: user.id).pluck(:id)).count)
  end
  @user_recipe_like_ranks = recipe_like_count.sort_by { |_, v| v }.reverse.to_h.keys
  
  counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:image)
  end
end
