class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.float :cost_of_goods
      t.float :menu_price

      t.timestamps
    end
  end
end
