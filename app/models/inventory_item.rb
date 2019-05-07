class InventoryItem < ApplicationRecord
  validates :amount_unit, presence: true
  validates :amount_value, presence: true
  validates :total_cost, presence: true
  validates :input_title, presence: true
  validates :input_supplier, presence: true

  belongs_to :ingredient, optional: true

  def nice_unit
    Unitwise(amount_value, amount_unit)
  end

  def unit_cost
    total_cost / amount_value
  end
end
