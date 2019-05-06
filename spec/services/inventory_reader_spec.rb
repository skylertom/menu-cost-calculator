require 'spec_helper'

describe InventoryReader do
  before do
    # load measurements
    %w(oz gal ct lb slices cup qt oz volume kil ea).each { |title| Measurement.create!(title: title) }
    Measurement
  end

  it 'should open the file' do
    expect(InventoryItem.count).to eq 0

    described_class.new('spec/fixtures/sample.xlsx').call

    expect(InventoryItem.count).to be > 0
    first_items_to_test = [
      ['BALDOR',	'2% Milk',	0.5,	'gal', 1.69 ]
    ]
    first_items_to_test.each do |supplier, title, amount, measurement, cost|
      item = InventoryItem.order(id: :asc).first
      expect(item.input_supplier).to eq supplier
      expect(item.input_title).to eq title
      expect(item.measurement.title).to eq measurement
      expect(item.total_cost).to eq cost
      expect(item.amount).to eq amount
    end

    last_items_to_test = [
      ['HOUSE',	'Whey Protein',	11.00,	'lb',	 118.99]
    ]
    last_items_to_test.each do |supplier, title, amount, measurement, cost|
      item = InventoryItem.order(id: :desc).first
      expect(item.input_supplier).to eq supplier
      expect(item.input_title).to eq title
      expect(item.measurement.title).to eq measurement
      expect(item.total_cost).to eq cost
      expect(item.amount).to eq amount
    end
  end
end