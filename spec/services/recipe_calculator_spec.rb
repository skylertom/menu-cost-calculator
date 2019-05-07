require 'spec_helper'

describe RecipeCalculator do
  before do 
    ingredients = create_ingredients
    create_inventory(ingredients)
    @recipe = create_recipe(ingredients)
  end

  # inventory list
  #   value [1, 2...]
  #   unit: kg
  #   total cost [1000, 2000...]
  # recipe item list
  #   value [1, 2...]
  #   unit kg
  it 'calculates recipe items cost with no conversion' do
    expect(@recipe.recipe_items.pluck(:calculated_cost)).to \
      match_array Array.new(5)

    described_class.call(@recipe)

    recipe_item_costs = [1000.0, 1000.0, 1000.0, 1000.0, 1000.0]
    expect(@recipe.recipe_items.order(:id).pluck(:calculated_cost)).to \
      match_array recipe_item_costs
    expect(@recipe.reload.cost_of_goods).to eq recipe_item_costs.sum
  end

  it 'calculates recipe items cost with no conversion' do
    InventoryItem.update_all(amount_value: 1, amount_unit: 'lb')
    expect(@recipe.recipe_items.pluck(:calculated_cost)).to \
      match_array Array.new(5)

    described_class.call(@recipe)

    # copied these vals from test, TODO eventually confirm these are correct
    recipe_item_costs = [2204, 4409, 6613, 8818, 11023]
    expect(@recipe.recipe_items.order(:id).pluck(:calculated_cost).map(&:floor)).to \
      match_array recipe_item_costs
    expect(@recipe.reload.cost_of_goods).to eq @recipe.recipe_items.pluck(:calculated_cost).sum
  end

  private

  def create_inventory(ingredients)
    ingredients.each_with_index do |ingredient, i|
      InventoryItem.create(input_title: "#{ingredient.title} A",
        input_supplier: "Baldor", ingredient_id: ingredient.id,
        total_cost: (i+1) * 1000, amount_value: i + 1, amount_unit: 'kg')
    end
  end

  def create_ingredients
    5.times.map { |i| Ingredient.create(title: "i #{i}") }
  end

  def create_recipe(ingredients)
    recipe = Recipe.create(title: 'Sample Recipe')
    ingredients.each_with_index do |ingredient, i|
      recipe.recipe_items.create(input_title: "Ingredient #{i}",
        amount_value: 1, amount_unit: 'kg',
        item: ingredient)
    end
    recipe
  end
end