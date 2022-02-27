module ParkingService
  class UnPark
    def self.run(id, exit_datetime = nil)
      parking = Parking.find_by_id(id)

      if parking.present?
        exit_datetime ||= DateService::CurrentDatetime.get
        parking.update_column(:exit_datetime, exit_datetime)

        duration = DateService::DateTimeDiff.get(parking.entry_datetime, parking.exit_datetime)

        slot = parking.slot
        amount = PaymentService::Compute.run(duration, slot.rate)
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
          slot_hourly_rate: slot.rate.to_f,
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
