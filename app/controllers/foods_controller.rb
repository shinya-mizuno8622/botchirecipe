class FoodsController < ApplicationController
  def destroy
    food = Food.find(params[:id])
    food.destroy
    flash[:success] = '材料を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  private
   
  def food_params
  params.require(:food).permit(:name,:cost,:number,:unit)
  end
end
