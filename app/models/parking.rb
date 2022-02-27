class Parking < ApplicationRecord
  has_one :slot

  ONE_DAY = 24.freeze
  BASE_RATE = 40.freeze
  ONE_DAY_RATE = 5000.freeze
  RATES = {
    'small' => 20,
    'medium' => 60,
    'large' => 100
  }.freeze

end
