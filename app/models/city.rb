class City < ApplicationRecord
  belongs_to :county
  has_many :cases
  attr_accessor :total_num_cases 

  def total_cases
    @total_num_cases ||= cases.map(&:count).reduce(:+) || 0
  end

  def cases_per_million
    (1_000_000 * total_cases / (population || 1)).round(0)
  end

  def chart_data
    data = (Case.first_case_date...Date.today).reduce({}) do |res, d|
      res.merge({ d.strftime('%m/%d/%Y') => 0 })
    end
    
    [{
      name: name,
      data: cases.reduce({}.merge(data)) do |res, c|
        res.merge({ c.date.strftime('%m/%d/%Y') => c.count })
      end.sort_by { |key| key }.to_h
    }]
  end
end
