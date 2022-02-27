class Api::V1::ParkingController < ApplicationController

  def index
    render json: ParkingService::List.get
  end

  def park
    render json: ParkingService::Park.run(params)
  end

  def un_park
    park_id = params[:id]
    exit_datetime = params[:exit_datetime]
    render json: ParkingService::UnPark.run(park_id, exit_datetime)
  end
end
