require 'SVG/Graph/TimeSeries'

class County < ApplicationRecord
  belongs_to :state
  has_many :cities

  def total_cases
    cities.map(&:total_cases).reduce(&:+) || 0
  end

  def graph
    first_date = Case.order(:date).first.date
    x_axis = (first_date..Date.today).map(&:to_s)
    options = {
      :width             => 640,
      :height            => 300,
      :stack             => :side,
      :fields            => x_axis,
      :graph_title       => "Cases in #{name} county",
      :show_graph_title  => true,
      :show_x_title      => true,
      :x_title           => 'Date',
      :show_y_title      => true,
      :y_title           => 'Number of Cases',
      :y_title_location  => :end,
      :no_css            => true,
      :key => true,
      :scale_x_integers => true,
      :scale_y_integers => true,
      :show_data_values => true,
      :show_x_guidelines => true,
      :y_title_text_direction => :bt,
      :stagger_x_labels => true,
      :x_label_format => "%m/%d",
      :timescale_divisions => "1 day",
      :min_y_value => 0
    }
    g = SVG::Graph::TimeSeries.new(options)
    cities.each do |city|
      case_data = city.cases.map do |kase|
        [kase.date.to_s, kase.count]
      end.flatten
      g.add_data({
        data: case_data,
        title: city.name,
        template: '%Y-%m-%d'
      })
    end
    g.burn_svg_only
  end
end
