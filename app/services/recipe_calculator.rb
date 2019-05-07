class RecipeCalculator < ApplicationService
	# Assumes ingredients, inventory set, recipe items set
	# calculates recipe items 
	# then calculates total recipe cost
	def initialize(recipe)
		@recipe = recipe
	end

	def call
		items = calculate_items(@recipe.recipe_items)
		calculate_recipe_cost(@recipe, items)
	end

	private

	def calculate_items(recipe_items)
		recipe_items.map do |recipe_item|
			update_item_cost(recipe_item)
			recipe_item
		end
	end

	def calculate_recipe_cost(recipe, items)
		recipe.update(total_cost: items.map(&:total_cost).sum)
	end

	def update_item_cost(recipe_item)
		if recipe_item.nice_unit.compatible_with?(recipe_item.item.nice_unit)
			calc_compatible_units(recipe_item, recipe_item.nice_unit, 
				recipe_item.item.nice_unit, recipe_item.item.total_cost)
		else
			raise NotImplementedError, "Conversion of different types"
		end
	end

	# price for all inventory units, not just one unit
	def calc_compatible_units(recipe_item, nice_recipe_unit, nice_inventory_unit, inventory_price)
		inventory_unit_price = unit_price(nice_inventory_unit, inventory_price)
		recipe_item.update(total_cost: 
			nice_recipe_unit.convert_to(nice_inventory_unit) * inventory_unit_price)
	end

	def unit_price(nice_unit, total_price)
		total_price.to_f / nice_unit.value #might want bigdecimal in future
	end
end