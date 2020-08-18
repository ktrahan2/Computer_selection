class CreateRecommendationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
      t.references :computer
      t.references :customer
      t.integer :number
    end
  end
end
