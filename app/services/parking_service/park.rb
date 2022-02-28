module ParkingService
  class Park
    def self.run(params)

      vehicle_type = params[:vehicle_type]
      plate_number = params[:plate_number]
      entry_point_id = params[:entry_point].to_i
      entry_point = EntryPoint.find_by_id(entry_point_id)

      if entry_point.present?

        available_slot = SlotService::NearestAvailable.run(entry_point_id, vehicle_type)

        if available_slot.present?

          datetime = params[:entry_datetime]
          datetime ||= DateService::CurrentDatetime.get

          parked = get_latest_parking(plate_number, datetime)
          if parked
            parked.update_column(:slot, available_slot)
            available_slot.update_column(:status, Slot::OCCUPIED)
            parked
          else
            parking = {
              slot: available_slot,
              entry_datetime: datetime,
              plate_number: params[:plate_number]
            }
            new_parking = Parking.create!(parking)
            available_slot.update_column(:status, Slot::OCCUPIED) if new_parking
            new_parking
          end
        else
          { error: 'No more slot available' }
        end
      else
        { error: 'Invalid entry point' }
      end
    end

    private
    def self.get_latest_parking(plate_number, entry_datetime)
      new_entry_datetime = entry_datetime.to_datetime
      condition = 'plate_number = ? AND exit_datetime >= ?'
      Parking.where(condition, plate_number, (new_entry_datetime - 1.hour))&.last
    end

  end
end
