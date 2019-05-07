class CreateRecipeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_items do |t|
      t.string :input_title
      t.string :item_type
      t.integer :item_id
      t.float :calculated_cost
      t.integer :recipe_id, null: false
      t.decimal :amount_value, null: false, precision: 10, scale: 4
      t.string :amount_unit, null: false, limit: 12

      t.timestamps
    end
  end
end
