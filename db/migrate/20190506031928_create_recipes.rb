class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.decimal :amount_value, precision: 10, scale: 4
      t.string :amount_unit, limit: 12
      t.float :total_cost, precision: 10, scale: 4
      t.float :menu_price, precision: 10, scale: 4
      t.string :type, null: false, default: 'MenuItem'

      t.timestamps
    end
  end
end
