class Recipe < ApplicationRecord
  belongs_to :user
  
  has_many :recipes_foods
  has_many :materials,dependent: :destroy,through: :recipes_foods,source: :food
  
  has_many :favorites
  has_many :liked, dependent: :destroy, through: :favorites, source: :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :process, presence: true, length: { maximum: 2000 }
  validates :time, presence: true, numericality: {only_integer: true}
  
  mount_uploader :image, ImageUploader
  
  def register(food)
    self.recipes_foods.find_or_create_by(food_id: food.id)
  end
  
  def unregister(food)
    registered = self.recipes_foods.find_by(food_id: food.id)
    registered.destroy if registered
  end
  
  def registered?(food)
  self.foods.include?(food)
  end
  
  def self.search(keyword)
  includes(:materials).where(["title like? OR process like? OR name like?", "%#{keyword}%","%#{keyword}%","%#{keyword}%"]).references(:materials)
  end 
  
end
