class DropPointsController < ApplicationController
  before_action :set_drop_point, only: [:show, :update, :destroy]

  # GET /drop_points
  def index
    @drop_points = DropPoint.all

    render json: @drop_points
  end

  # GET /drop_points/1
  def show
    render json: @drop_point
  end

  # POST /drop_points
  def create
    @drop_point = DropPoint.new(drop_point_params)

    if @drop_point.save
      render json: @drop_point, status: :created, location: @drop_point
    else
      render json: @drop_point.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drop_points/1
  def update
    if @drop_point.update(drop_point_params)
      render json: @drop_point
    else
      render json: @drop_point.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drop_points/1
  def destroy
    @drop_point.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop_point
      @drop_point = DropPoint.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drop_point_params
      params.require(:drop_point).permit(:route_id, :location_id)
    end
end
