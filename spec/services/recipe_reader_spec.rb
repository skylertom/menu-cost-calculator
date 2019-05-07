require 'spec_helper'

describe RecipeReader do
  before do
    # load measurements - no longer necessary
    %w(slice ladel tb oz gal ct lb slices cup qt oz volume kil ea)
  end

  it 'should save recipe items to database' do
    expect(Recipe.count).to eq 0
    expect(RecipeItem.count).to eq 0

    described_class.new('spec/fixtures/sample.xlsx').call

    expect(Recipe.count).to be > 0
    expect(RecipeItem.count).to be > 0

    recipe = Recipe.order(id: :asc).first
    expect(recipe.title).to eq 'Avocado Toast'
    data = [
      ['FANTINI', 'Multigrain Loaf', 1, 'slice'],
      ['BALDOR', 'Ripe Avocados', 0.25, 'ct'],
      ['HOUSE', 'Average Spice', 0.05, 'tb']
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_supplier).to eq data[i][0]
      expect(item.input_title).to eq data[i][1]
      expect(item.amount_value).to eq data[i][2]
      expect(item.amount_unit).to eq data[i][3]
    end

    recipe = Recipe.order(id: :asc).second
    expect(recipe.title).to eq 'Vegan Tacos'
    data = [
      ['MARKET B', "Corn Tortillas", 4, "ct"],
      ['BALDOR', "Organic Firm Tofu", 3.5, "oz"],
      ['BALDOR', "Brussels Sprouts", 1.125, "oz"],
      ['AMAZON', "Yeast", 3, "tb"],
      ['HOUSE', "Chipotle Mayo", 1.5, "oz"],
      ['BALDOR', "Ripe Avocados", 0.25,	"ct"],
      ['HOUSE', "Chili Yeast", 0.1, "oz"],
      ['PFG', "Limes", 0.167,	"ea"]
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_supplier).to eq data[i][0]
      expect(item.input_title).to eq data[i][1]
      expect(item.amount_value).to eq data[i][2]
      expect(item.amount_unit).to eq data[i][3]
    end
  end
end