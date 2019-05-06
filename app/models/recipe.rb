class Recipe < ApplicationRecord
  validates :title, presence: true

  has_many :recipe_items
  # TODO once implemented
  #belongs_to :company
end
