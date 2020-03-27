class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.references :city, null: false, foreign_key: true
      t.integer :count
      t.date :date

      t.timestamps
    end
  end
end
