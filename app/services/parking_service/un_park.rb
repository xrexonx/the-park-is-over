module ParkingService
  class UnPark
    def self.run(id, exit_datetime = nil)
      parking = Parking.find_by_id(id)

      if parking.present?

        prev_exit_datetime = parking.exit_datetime
        prev_payment = nil
        prev_payment = Payment.where(parking_id: parking.id).last if prev_exit_datetime.present?

        exit_datetime ||= DateService::CurrentDatetime.get
        parking.update_column(:exit_datetime, exit_datetime)

        entry_datetime = prev_payment ? prev_exit_datetime : parking.entry_datetime
        duration = DateService::DateTimeDiff.get(entry_datetime, parking.exit_datetime)

        slot = parking.slot
        rate = slot.rate
        amount = prev_payment ? duration * rate : PaymentService::Compute.run(duration, rate)
        payment = {
          duration: duration,
          amount: amount,
          parking: parking
        }

        Payment.create!(payment)
        slot.update_column(:status, Slot::AVAILABLE)

        {
          entry_datetime: parking.entry_datetime,
          exit_datetime: parking.exit_datetime,
          base_rate: Parking::BASE_RATE.to_f,
          slot_hourly_rate: rate.to_f,
          duration: duration,
          amount: amount.to_f,
          slot: slot.name,
          vehicle: parking.plate_number
        }
      else
        { error: 'No parking data found' }
      end

    end
  end
end
