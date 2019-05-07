class RecipeCalculator < ApplicationService
	# Assumes ingredients, inventory set, recipe items set
	# calculates recipe items 
	# then calculates total recipe cost
	def initialize(recipe)
		@recipe = recipe
	end

	def call
	end
end