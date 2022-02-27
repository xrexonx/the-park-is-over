class Api::V1::SlotController < ApplicationController

  def index
    render json: SlotService::List.get
  end
end
