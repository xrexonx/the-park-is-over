module ParkingService
  class Park
    def self.run(params)

      entry_point_id = params[:entry_point].to_i
      entry_point = EntryPoint.find_by_id(entry_point_id)

      if entry_point.present?

        parking_rate = Parking::RATES[params[:vehicle_type]]
        available_slot = SlotService::NearestAvailable.run(entry_point_id, parking_rate)

        if available_slot.present?

          datetime = params[:entry_datetime]
          datetime ||= DateService::CurrentDatetime.get

          parking = {
            slot: available_slot,
            entry_datetime: datetime,
            plate_number: params[:plate_number]
          }

          parked = Parking.create!(parking)
          available_slot.update_column(:status, Slot::OCCUPIED) if parked
          parked
        else
          { error: 'No more slot available' }
        end
      else
        { error: 'Invalid entry point' }
      end
    end

  end
end
