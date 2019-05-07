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
      ['Multigrain Loaf', 1, 'slice'],
      ['Ripe Avocados', 0.25, 'ct'],
      ['Average Spice', 0.05, 'tb']
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_title).to eq data[i][0]
      expect(item.amount_value).to eq data[i][1]
      expect(item.amount_unit).to eq data[i][2]
    end

    recipe = Recipe.order(id: :asc).second
    expect(recipe.title).to eq 'Vegan Tacos'
    data = [
      ["Corn Tortillas", 4, "ct"],
      ["Organic Firm Tofu", 3.5, "oz"],
      ["Brussels Sprouts", 1.125, "oz"],
      ["Yeast", 3, "tb"],
      ["Chipotle Mayo", 1.5, "oz"],
      ["Ripe Avocados", 0.25,	"ct"],
      ["Chili Yeast", 0.1, "oz"],
      ["Limes", 0.167,	"ea"]
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_title).to eq data[i][0]
      expect(item.amount_value).to eq data[i][1]
      expect(item.amount_unit).to eq data[i][2]
    end
  end
end