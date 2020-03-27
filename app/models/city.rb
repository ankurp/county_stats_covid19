class City < ApplicationRecord
  belongs_to :county
  has_many :cases

  def total_cases
    cases.map(&:count).reduce(:+)
  end
end
