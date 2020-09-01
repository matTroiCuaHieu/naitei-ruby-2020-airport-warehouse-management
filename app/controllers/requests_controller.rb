class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :find_request, except: %i(new create index)

  def index
    @requests = Request.order(id: :desc).page(params[:page]).per Settings.pagination.user_page
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    if @request.save
      redirect_to requests_path
      flash[:success] = t "planes.index.add_success"
    else
      flash[:error] = t "planes.plane.add_fail"
      @plane_id = params.require(:request)[:plane_id]
      render "new"
    end
  end

  def show
    return unless request.referer.include? Settings.request.referrer.new

    plane = Plane.find_by id: params[:id]
    location = if plane.ready?
                 Location.location_false.gara_false
               else
                 Location.location_false.ready_false
               end
    render json: {location: location}
  end

  def edit; end

  def update
    if current_user.manager?
      manager_update
    else
      user_update
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "requests.index.delete_success"
    else
      flash[:error] = t "requests.index.delete_failed"
    end

    respond_to do |format|
      format.html{redirect_to requests_url}
      format.js {}
    end
  end

  private

  def request_params
    params.require(:request).permit Request::REQUESTS_PARAMS
  end

  def find_request
    @request = Request.find_by id: params.require(:id)
    return if @request

    flash[:error] = t "static_pages.home.not_found_request"
    redirect_to root_url
  end

  def update_if_deny
    @request.update!(status: Settings.request.status.denied,
        approver: current_user.name, deny_reason: params[:deny_reason])
  end

  def manager_update
    if params[:status].eql? Settings.request.status.accepted
      @request.update_value? @request, current_user
      flash[:success] = t "requests.index.accept_success"
    else
      update_if_deny
      flash[:success] = t "requests.index.deny_success"
    end
    redirect_to @request
  end

  def user_update
    if @request.update request_params
      flash[:success] = t "requests.index.edit_success"
      redirect_to requests_path
    else
      flash[:error] = t "requests.edit.edit_fail"
      render :edit
    end
  end
end
