class ToppagesController < ApplicationController
  def index
    @user = current_user
    
    @recipes = Recipe.order(id: :desc)
    
    best_recipes = Recipe.includes(:liked).sort {|a,b| b.liked.size <=> a.liked.size}
    @best_recipes = Kaminari.paginate_array(best_recipes).page(params[:page]).per(1)
    
    @fast_recipes = Recipe.order(time: :asc).page(params[:page]).per(3)
    
    @cheep_recipes = Recipe
    .joins(:materials)
    .group(:recipe_id)
    .order('sum(cost) desc')
    
    counts(@user)
    #↑application_controllerのdef counts(user)を使うため
  end
end
