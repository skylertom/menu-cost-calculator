class InventoryItem < ApplicationRecord
  belongs_to :ingredient, optional: true
  belongs_to :measurement

  validates :measurement_id, presence: true
  validates :amount, presence: true
  validates :total_cost, presence: true
  validates :input_title, presence: true
  validates :input_supplier, presence: true
  # later can move measurement to an `input_measurement`
end
