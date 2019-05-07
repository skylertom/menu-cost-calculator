class InventoryItem < ApplicationRecord
  belongs_to :ingredient, optional: true

  validates :amount_unit, presence: true
  validates :amount_value, presence: true
  validates :total_cost, presence: true
  validates :input_title, presence: true
  validates :input_supplier, presence: true
  # later can move measurement to an `input_measurement`

  def nice_unit
    Unitwise(amount_value, amount_unit)
  end
end
