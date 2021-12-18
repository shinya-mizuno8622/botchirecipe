class CreateRecipesFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes_foods do |t|
      t.references :recipe, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
