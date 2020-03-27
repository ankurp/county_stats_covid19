class County < ApplicationRecord
  belongs_to :state
  has_many :cities

  def total_cases
    cities.map(&:total_cases).reduce(&:+) || 0
  end
end
