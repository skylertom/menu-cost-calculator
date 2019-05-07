require "administrate/base_dashboard"

class RecipeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    recipe_items: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    cost_of_goods: Field::String.with_options(searchable: false),
    menu_price: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :recipe_items,
    :id,
    :title,
    :cost_of_goods,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :recipe_items,
    :id,
    :title,
    :cost_of_goods,
    :menu_price,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :recipe_items,
    :title,
    :cost_of_goods,
    :menu_price,
  ].freeze

  # Overwrite this method to customize how recipes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recipe)
  #   "Recipe ##{recipe.id}"
  # end
end
