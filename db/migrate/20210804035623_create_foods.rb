class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :cost
      t.integer :number
      t.string :unit
      
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
