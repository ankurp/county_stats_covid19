module Admin
  class CasesController < Admin::ApplicationController
    def new
      @counties = County.all
      resource = Case.new(date: Date.today, count: 0)
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }
    end

    def create
      date = params[:case][:date]
      kases = []
      params[:cases].each do |key, kase|
        kases << Case.new(date: date, count: kase[:count], city_id: kase[:city_id])
      end
      if kases.map(&:save).all?
        redirect_to(
          [namespace, resource_class],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end
  end
end
