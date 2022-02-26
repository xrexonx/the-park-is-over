class Api::V1::ParkingController < ApplicationController

  def index
    render json: EntryPoint.all
  end

  def park
    p params
  end

  def unpark
    p params
  end
end
