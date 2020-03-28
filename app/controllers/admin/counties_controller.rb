module Admin
  class CountiesController < Admin::ApplicationController
    def new_cases
      @county = County.includes(:cities).find(params[:id])
    end
  end
end
