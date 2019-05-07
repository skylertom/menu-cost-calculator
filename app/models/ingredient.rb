class Ingredient < ApplicationRecord
  validates :title, presence: true

  has_many :inventory_items
  has_many :recipe_items, as: :item
end
