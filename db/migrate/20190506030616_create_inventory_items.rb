class CreateInventoryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_items do |t|
      t.string :input_title, null: false
      t.string :input_supplier, null: false
      t.integer :ingredient_id
      t.decimal :total_cost, null: false, precision: 10, scale: 4
      t.decimal :amount_value, null: false, precision: 10, scale: 4
      t.string :amount_unit, null: false, limit: 12

      t.timestamps
    end
  end
end
