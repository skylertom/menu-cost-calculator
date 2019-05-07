class Readers::RecipeReader < ApplicationService
  def initialize(file_path)
		@file_path = file_path
		@counter = 0
  end

	# eventually use activerecord_import for speed/efficiency
	def call
		recipe = nil
		rows.each do |row|
			increment_counter
			if menu_row?(row)
				recipe = MenuItem.create(title: row['D'])
			elsif recipe_line_item?(row)
				create_recipe_item(recipe, row)
			elsif blank_row?(row)
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
		row['B'] == 'MENU ITEM:'
	end

	def recipe_line_item?(row)
		row['B'].present? && row['B'] != 'Supplier'
	end

	def blank_row?(row)
		row['B'] != 'Supplier'
	end

  # Assume content is in the fourth Excel sheet (snacks)
  def rows
    @rows ||= book.sheets.fourth.simple_rows
  end

  def increment_counter
    @counter += 1
  end

  def row_count
    @row_count ||= rows.count
  end

	def create_recipe_item(recipe, row)
		# B is supplier
		# C is purchase amount
		# D is purchase measurment
		# E is purchase cost (not calculated)
		# I is conversion calculation
		# J is calculated cost
		recipe.recipe_items.create(
			input_supplier: row['B'],
			input_title: row['C'],
			amount_value: row['G'],
			amount_unit: row['H']
		)
	end
end
