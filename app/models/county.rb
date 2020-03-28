class County < ApplicationRecord
  belongs_to :state
  has_many :cities

  def total_cases
    cities.map(&:total_cases).reduce(&:+) || 0
  end

  def chart_data
    first_date = Case.order(:date).first.date
    data = (first_date..Date.today).reduce({}) do |res, d|
      res.merge({ d => 0 })
    end
    result = cities.map { |city|
      {
        name: city.name,
        data: city.cases.reduce({}.merge(data)) do |res, c|
          res.merge({ c.date => c.count })
        end
      }
    }
    result
  end
end
