class LocationsController < ApplicationController
  def index
    @locations = Location.page(params[:page]).per Settings.pagination
  end
end
