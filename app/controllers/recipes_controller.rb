class RecipesController < ApplicationController
  before_action :correct_user, only: [:destroy,:edit,:update]

  def show
  @recipe = Recipe.find(params[:id])
  @materials = @recipe.materials.page(params[:page]).per(20)
  end

  def new
  @recipe = Recipe.new
  end

  def create
  @recipe = current_user.recipes.build(recipe_params)
   if @recipe.save
   flash[:success]='レシピを書きました。'
   redirect_to materials_recipe_path(@recipe)
   else
   flash.now[:danger] = 'メッセージの投稿に失敗しました。（全ての項目を入力、時間は必ず半角数字を入力、写真は必須ではありません。）'
   render 'recipes/new'
   end
  end

  def destroy
  @recipe.destroy
  flash[:success] = 'レシピを削除しました。'
  redirect_to root_url
  end

  def edit
  @recipe = Recipe.find(params[:id])
  end

  def update
  @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
    flash[:success] = 'レシピは正常に更新されました'
    redirect_to @recipe
    else
    flash.now[:danger] = 'レシピは更新されませんでした'
    render :edit
    end
  end
  
  def recipe_params
  params.require(:recipe).permit(:title,:description,:process,:time,:image)
  end
  
  def materials
  @recipe = Recipe.find(params[:id])
  @materials = @recipe.materials.page(params[:page]).per(20)
  end
  
  def ranking
  @user = current_user
  best_recipes = Recipe.includes(:liked).sort {|a,b| b.liked.size <=> a.liked.size}
  @best_recipes = Kaminari.paginate_array(best_recipes).page(params[:page]).per(25)
  counts(@user)
  end
  
  def fast
  @fast_recipes = Recipe.order(time: :asc).page(params[:page]).per(25)
  end
  
  def cheep
  @cheep_recipes = Recipe
  .joins(:materials)
  .group(:recipe_id)
  .order('sum(cost) desc')
  end
  
  def search
  @recipes = Recipe.search(params[:keyword])
  @keyword = params[:keyword]
  render "index"
  end
  
  def all_recipes
  @user = current_user
  @recipes = Recipe.order(id: :desc).page(params[:page]).per(25)
  counts(@user)
  end
  
  
  private
  
  def food_params
  params.require(:food).permit(:name,:cost,:number,:unit)
  end
  
  def correct_user
  @recipe = current_user.recipes.find_by(id: params[:id])
   unless @recipe
   redirect_to root_url
   end
  end
end