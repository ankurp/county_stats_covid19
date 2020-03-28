class County < ApplicationRecord
  belongs_to :state
  has_many :cities

  def total_cases
    cities.map(&:total_cases).reduce(&:+) || 0
  end

  def chart_data
    result = cities.map { |city|
      {
        name: city.name,
        data: city.cases.reduce({}) do |result, c|
          result.merge({ c.date => c.count })
        end
      }
    }
    result
  end
end
