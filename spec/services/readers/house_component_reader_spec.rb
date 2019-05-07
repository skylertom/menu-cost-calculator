require 'spec_helper'

describe Readers::HouseComponentReader do
  it 'should save recipe items to database' do
    expect(HouseComponent.count).to eq 0
    expect(RecipeItem.count).to eq 0

    described_class.new('spec/fixtures/sample.xlsx').call

    expect(HouseComponent.count).to be > 0
    expect(RecipeItem.count).to be > 0

    recipe = HouseComponent.order(id: :asc).first
    expect(recipe.title).to eq 'Turkey Burger'
    # supplier title purchase-quant, purchase price, batch amount
    data = [
      ["PFG",	"Ground Turkey",	20,"lb", 59.75,5.00,"lb"],
      ["HOUSE",	"Chipolte Paste",	3,"qt", 2.76,2.00,"tb"],
      ["HOUSE",	"Average Spice",	1,"tb", 0.18,1.50,"tb"],
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_supplier).to eq data[i][0]
      expect(item.input_title).to eq data[i][1]
      expect(item.amount_value).to eq data[i][5]
      expect(item.amount_unit).to eq data[i][6]
    end
    expect(recipe.amount_value).to eq 5.0
    expect(recipe.amount_unit).to eq "lb"

    recipe = HouseComponent.order(id: :asc).second
    expect(recipe.title).to eq 'Pesto'
    data = [
      ["PFG",	"Olive Oil",	12,	"lt",	 69.79, 	8.00,	"cup"],
      ["PFG",	"Basil (fresh)",	2,	"lb",	 20.76, 	2.25,	"bag"],
      ["BALDOR",	"Frozen Lemon Juice",	6,	"lt",	 21.60, 	3.00,	"cup"],
      ["AMAZON",	"Yeast",	10,	"lb",	 105.66, 	1.50,	"cup"],
      ["BALDOR",	"Peeled Garlic",	20,	"lb",	 10.50, 	3.00,	"tb"],
      ["HOUSE",	"Average Spice",	1,	"tb",	 0.18, 	2.00,	"tb"],
      ["BALDOR",	"Beaufor Dijon Mustard",	11,	"lb",	 18.00, 	2.00,	"cup"]
    ]
    recipe.recipe_items.order(id: :asc).each_with_index do |item, i|
      expect(item.input_supplier).to eq data[i][0]
      expect(item.input_title).to eq data[i][1]
      expect(item.amount_value).to eq data[i][5]
      expect(item.amount_unit).to eq data[i][6]
    end
    expect(recipe.amount_value).to eq 15.0
    expect(recipe.amount_unit).to eq "cup"
  end
end