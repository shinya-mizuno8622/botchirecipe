class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.text :process
      t.integer :time
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
