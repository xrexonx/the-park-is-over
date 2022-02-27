module ParkingService
  class UnPark
    def self.run(id, exit_datetime = nil)
      parking = Parking.find_by_id(id)

      if parking.present?
        exit_datetime ||= DateService::CurrentDatetime.get
        parking.update_column(:exit_datetime, exit_datetime)

        time_diff = get_time_diff(parking.exit_datetime, parking.entry_datetime)

        slot = parking.slot
        amount = compute_payment(time_diff, slot.rate)
        payment = {
          duration: time_diff,
          amount: amount,
          parking: parking
        }

        Payment.create!(payment)
        slot.update_column(:status, Slot::AVAILABLE)

        {
          entry_datetime: parking.entry_datetime,
          exit_datetime: parking.exit_datetime,
          duration: time_diff,
          amount: amount.to_f,
          slot: slot.name,
          vehicle: parking.plate_number
        }
      else
        { error: 'No parking data found' }
      end

    end

    private
    def self.compute_payment(hours_ago, rate)
      amount = Parking::BASE_RATE + ((hours_ago - 1) * rate)
      amount = Parking::ONE_DAY_RATE + ((hours_ago - Parking::ONE_DAY) * rate) if hours_ago >= Parking::ONE_DAY
      amount
    end

    def self.get_time_diff(exit_datetime, entry_datetime)
      time_diff = ((exit_datetime - entry_datetime) / 1.hour)
      (time_diff.to_f).ceil
    end
  end
end
