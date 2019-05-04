class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :description
      t.float :price
      t.float :time

      t.timestamps
    end
  end
end
