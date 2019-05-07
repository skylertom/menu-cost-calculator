class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.decimal :cost_of_goods, precision: 10, scale: 4
      t.decimal :menu_price, precision: 10, scale: 4

      t.timestamps
    end
  end
end
