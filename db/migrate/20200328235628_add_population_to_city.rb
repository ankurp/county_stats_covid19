class AddPopulationToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :population, :integer
  end
end
