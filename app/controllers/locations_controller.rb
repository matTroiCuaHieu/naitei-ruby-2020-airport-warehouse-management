class LocationsController < ApplicationController
  def index
    @locations = Location.page(params[:page]).per Settings.pagination.user_page
  end
end
