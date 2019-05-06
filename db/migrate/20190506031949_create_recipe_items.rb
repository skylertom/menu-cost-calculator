class CreateRecipeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_items do |t|
      t.string :input_title
      t.string :item_type
      t.integer :item_id
      t.integer :measurement_id
      t.float :amount, null: false
      t.float :calculated_cost
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end
end
