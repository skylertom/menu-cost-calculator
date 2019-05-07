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
		recipe.update(cost_of_goods: items.map(&:calculated_cost).sum)
	end

	def update_item_cost(recipe_item)
		# this exact way the relationship works can change in the future
		if recipe_item.item.is_a?(Ingredient)
			# assumes that there is ony one inventory item per ingredient
			# TODO probably have recipe items directly link to inventory items
			handle_inventory_item(recipe_item, recipe_item.item.inventory_items.first)
		else
			handle_house_component(recipe_item, recipe_item.item)
		end
	end

	def handle_inventory_item(recipe_item, inventory_item)
		if recipe_item.nice_unit.compatible_with?(inventory_item.nice_unit)
			calc_compatible_units(recipe_item, recipe_item.nice_unit, 
				inventory_item.nice_unit, inventory_item.total_cost)
		else
			raise NotImplementedError, "Conversion of different types"
		end
	end

	def handle_house_component(_recipe_item, _house_component)
		raise NotImplementedError, 'House Components not implemented yet'
	end

	# price for all inventory units, not just one unit
	def calc_compatible_units(recipe_item, nice_recipe_unit, nice_inventory_unit, inventory_price)
		inventory_unit_price = unit_price(nice_inventory_unit, inventory_price)
		recipe_item.update(calculated_cost: 
			nice_recipe_unit.convert_to(nice_inventory_unit) * inventory_unit_price)
	end

	def unit_price(nice_unit, total_price)
		total_price.to_f / nice_unit.value #might want bigdecimal in future
	end
end