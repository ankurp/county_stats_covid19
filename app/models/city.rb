class City < ApplicationRecord
  belongs_to :county
  has_many :cases
  attr_accessor :total_num_cases 

  default_scope { where(is_hidden: false) }

  def total_cases
    @total_num_cases ||= cases.map(&:count).reduce(:+) || 0
  end

  def cases_per_million
    (1_000_000 * total_cases / (population || 1)).round(0)
  end

  def chart_data
    first_date = cases.order(:date).first.try(:date) || Date.today
    data = (first_date..Date.today).reduce({}) do |res, d|
      res.merge({ d => 0 })
    end
    
    [{
      name: name,
      data: cases.reduce({}.merge(data)) do |res, c|
        res.merge({ c.date => c.count })
      end
    }]
  end
end
