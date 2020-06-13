class UserVehiclesController < ApplicationController
  before_action :driver_only
  skip_before_action :admin_only

  def show
    @vehicle = current_user.vehicle

    if @vehicle.nil?
      head 404
    end
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    if current_user.vehicle.nil?
      @vehicle.user = current_user
      if @vehicle.save
        render :show, status: :created
      else
        render json: @vehicle.errors, status: :unprocessable_entity
      end
    else
      head 403
    end
  end

  def update
    @vehicle = current_user.vehicle

    if @vehicle.nil?
      return head 404
    end

    if @vehicle.update(vehicle_params)
      render :show
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  private
    def vehicle_params
      params.require(:vehicle).permit(:brand, :model, :plate_code, :color, :picture)
    end
end
