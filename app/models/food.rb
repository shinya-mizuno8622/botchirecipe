class Food < ApplicationRecord
  has_many :recipes_foods,dependent: :destroy
  has_many :recipes,through: :recipes_foods
  
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :unit, presence: true, length: { maximum: 10 }
  validates :number, presence: true, numericality: {only_integer: true}
  validates :cost, presence: true, numericality: {only_integer: true}
  
  

end
