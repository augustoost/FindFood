class AddCategoryIdToDish < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :category_id, :integer
  end
end
