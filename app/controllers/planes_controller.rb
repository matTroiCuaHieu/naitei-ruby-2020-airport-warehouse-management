class PlanesController < ApplicationController
  def index
    @planes = Plane.page(params[:page]).per Settings.pagination
  end
end
