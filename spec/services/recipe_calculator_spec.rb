require 'spec_helper'

describe RecipeCalculator do
  before do 
    ingredients = create_ingredients
    create_inventory(ingredients)
    @recipe = create_recipe(ingredients)
  end

  it 'calculates recipe items cost' do
    expect(@recipe.recipe_items.pluck(:calculated_cost)).to \
      match_array Array.new(5)

    described_class.call(@recipe)
  end

  def create_inventory(ingredients)
    ingredients.each_with_index do |ingredient, i|
      InventoryItem.create(input_title: "#{ingredient.title} A",
        input_supplier: "Baldor", ingredient_id: ingredient.id,
        total_cost: i * 100, amount_value: i, amount_unit: 'kg')
    end
  end

  def create_ingredients
    5.times.map { |i| Ingredient.create(title: "i #{i}") }
  end

  def create_recipe(ingredients)
    recipe = Recipe.create(title: 'Sample Recipe')
    ingredients.each_with_index do |ingredient, i|
      recipe.recipe_items.create(input_title: "Ingredient #{i}",
        amount_value: i, amount_unit: 'g',
        item: ingredient)
    end
    recipe
  end
end