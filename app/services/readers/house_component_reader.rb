class Readers::HouseComponentReader < ApplicationService
  def initialize(file_path)
		@file_path = file_path
		@counter = 0
  end

	# TODO problems reading in some things when there are items like "Water" with no supplier
	def call
		recipe = nil
		rows.each do |row|
			increment_counter
			if menu_row?(row)
				recipe = HouseComponent.create(title: row['D'])
			elsif recipe && recipe_line_item?(row)
				create_recipe_item(recipe, row)
			elsif recipe && weight_row?(row)
				update_recipe(recipe, row)
				recipe = nil
			end
    end
  end

  private

  attr_reader :file_path
	attr_accessor :counter
	
  def book
    @book ||= Creek::Book.new(file_path)
	end

	def menu_row?(row)
		row['B'] == 'HOUSE-MADE COMPONENT'
	end

	def recipe_line_item?(row)
		row['B'].present? && row['B'].is_a?(String) && row['B'].downcase != 'supplier'
	end

	def blank_row?(row)
		row['B'].blank? || row['B']&.downcase != 'supplier'
	end

	def weight_row?(row)
		# I has "weight" 
		row['I'].present? && row['I'].is_a?(String) && row['I'].downcase == 'weight'
	end

  # Assume content is in the third Excel sheet (snacks)
  def rows
    @rows ||= book.sheets.third.simple_rows
  end

  def increment_counter
    @counter += 1
  end

  def row_count
    @row_count ||= rows.count
  end

	def create_recipe_item(recipe, row)
		# B is supplier
		# C is title
		# D is purchase amount
		# E is purchase measurment
		# F is purchase cost
		# G is amount needed
		# H is unit needed
		recipe.recipe_items.create(
			input_supplier: row['B'],
			input_title: row['C'],
			amount_value: row['G'],
			amount_unit: row['H']
		)
	end

	def update_recipe(recipe, row)
		# J has "weight" but really is just the amount
		# K contains unit for total amount
		recipe.update(amount_value: row['J'], amount_unit: row['K'])
	end
end
