class LocationsController < ApplicationController
  def index
    @locations = Location.page(params[:page]).per Settings.pagination.locations_page
    @radars = get_radar
    @readys = get_ready
  end

  def get_ready
    Location.where(warehouse_id: Settings.warehouse.ready)
  end

  def get_radar
    Location.where(warehouse_id: Settings.warehouse.gara)
  end
end
