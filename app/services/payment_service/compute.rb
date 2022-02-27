module PaymentService
  class Compute
    def self.run(duration, rate)
      base_hours = 3
      if duration <= base_hours
        Parking::BASE_RATE
      elsif duration >= Parking::ONE_DAY
        Parking::ONE_DAY_RATE + ((duration - Parking::ONE_DAY) * rate)
      else
        Parking::BASE_RATE + ((duration - base_hours) * rate)
      end
    end
  end
end