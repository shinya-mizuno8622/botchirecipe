class RecipesFoodsController < ApplicationController
before_action :correct_user, only: [:create,:destroy]

  def index
    @foods = Food.order(id: :desc)
  end
  
  def new
    @food=Food.new
  end
  
  def create
    @food = Food.new(food_params)
    if @food.save
    recipe = Recipe.find(params[:id])
    recipe.register(@food)
    flash[:success]='材料を登録しました'
    redirect_back(fallback_location: recipe_path)
    else
    flash[:danger] = '材料の登録に失敗しました。（全ての項目を入力、費用・数は必ず半角数字を入力。）'
    redirect_back(fallback_location: recipe_path)
    # redirect_back(fallback_location: recipe_path)
    end
  end

  private
  
  def food_params
  params.permit(:name,:cost,:number,:unit)
  end
  
  def correct_user
  @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe
     flash[:success]='材料を登録できるのは、このレシピを作った人だけです。' 
     redirect_back(fallback_location: recipe_path)
    end
  end
  
end
