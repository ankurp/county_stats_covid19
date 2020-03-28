class HomeController < ApplicationController
  def index
    @counties = County.all.includes(cities: :cases)
  end

  def terms
  end

  def privacy
  end
end
