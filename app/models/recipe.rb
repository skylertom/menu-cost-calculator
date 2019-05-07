class Recipe < ApplicationRecord
  TYPES = %w(HouseComponent MenuItem)
  validates :title, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }

  has_many :recipe_items
  # TODO once implemented
  #belongs_to :company
end
