class CitiesController < ApplicationController
  def show
    @city = City.find_by_id(params[:id])
  end

  def to_param
    "#{id}-#{name.title.parameterize}"
  end
end
