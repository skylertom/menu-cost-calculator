require "administrate/base_dashboard"

class InventoryItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    ingredient: Field::BelongsTo,
    id: Field::Number,
    input_title: Field::String,
    input_supplier: Field::String,
    total_cost: Field::String.with_options(searchable: false),
    amount_value: Field::String.with_options(searchable: false),
    amount_unit: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :ingredient,
    :id,
    :input_title,
    :input_supplier,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :ingredient,
    :id,
    :input_title,
    :input_supplier,
    :total_cost,
    :amount_value,
    :amount_unit,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :ingredient,
    :input_title,
    :input_supplier,
    :total_cost,
    :amount_value,
    :amount_unit,
  ].freeze

  # Overwrite this method to customize how inventory items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(inventory_item)
  #   "InventoryItem ##{inventory_item.id}"
  # end
end
