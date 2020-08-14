class PlanesController < ApplicationController
  def index
    @planes = Plane.page(params[:page]).per Settings.pagination.user_page
  end
end
