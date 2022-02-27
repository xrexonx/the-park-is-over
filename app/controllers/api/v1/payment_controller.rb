class Api::V1::PaymentController < ApplicationController

  def index
    render json: PaymentService::List.get
  end
end
