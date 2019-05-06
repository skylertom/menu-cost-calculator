class Ingredient < ApplicationRecord
  validates :title, presence: true

  has_many :inventory_items
end
