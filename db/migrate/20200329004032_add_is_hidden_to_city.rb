class AddIsHiddenToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :is_hidden, :boolean, default: false
  end
end
