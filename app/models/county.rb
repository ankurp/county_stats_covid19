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
    cities.sort_by(&:total_cases).reverse.reduce({}) { |result, city|
      result.merge({
        city.name => city.total_cases
      })
    }
  end
end
