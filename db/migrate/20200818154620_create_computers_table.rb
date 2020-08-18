class CreateComputersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :computers do |t|
      t.string :brand
      t.string :model
      t.float :price
      t.string :function
      t.string :dimensions
      t.string :status
      t.string :warranty
    end
  end
end
