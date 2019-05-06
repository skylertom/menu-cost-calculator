class CreateInventoryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_items do |t|
      t.string :input_title, null: false
      t.string :input_supplier, null: false
      t.integer :ingredient_id
      t.integer :measurement_id
      t.float :total_cost, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
