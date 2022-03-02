module ParkingService
  class Park
    def self.run(params)

      vehicle_type = params[:vehicle_type]
      plate_number = params[:plate_number]
      entry_point_id = params[:entry_point].to_i
      datetime = params[:entry_datetime]
      datetime ||= DateService::CurrentDatetime.get

      # Check first if valid entry point
      return { error: 'Invalid entry point' } unless EntryPoint.find_by_id(entry_point_id).present?

      # get nearest available slot by entry point and vehicle type
      available_slot = SlotService::NearestAvailable.run(entry_point_id, vehicle_type)

      if available_slot.present?

        # check vehicle if returned with in an hour by plate number and entry datetime
        returned, parking = vehicle_returned?(plate_number, datetime)
        if returned
          # update existing parking date
          parking.slot = available_slot
          parking.save!
        else
          # create new parking data
          new_parking = {
            slot: available_slot,
            entry_datetime: datetime,
            plate_number: params[:plate_number]
          }
          parking = Parking.create!(new_parking)
        end
        # update slot to occupied
        available_slot.update_column(:status, Slot::OCCUPIED)
        parking
      else
        { error: 'No more slot available' }
      end
    end

    private
    def self.vehicle_returned?(plate_number, entry_datetime)
      parking = Parking.where('plate_number = ? AND exit_datetime >= ?', plate_number, (entry_datetime.to_datetime - 1.hour))&.last
      parking ? [true, parking] : [false, nil]
    end

  end
end
