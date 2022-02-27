module PaymentService
  class Compute
    def self.run(duration, rate)
      amount = Parking::BASE_RATE + ((duration - 1) * rate)
      amount = Parking::ONE_DAY_RATE + ((duration - Parking::ONE_DAY) * rate) if duration >= Parking::ONE_DAY
      amount
    end
  end
end