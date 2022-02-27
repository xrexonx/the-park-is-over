module SlotService
  class NearestAvailable
    def self.run(entry_point, vehicle_type)
      parking_rate = Parking::RATES[vehicle_type]
      Slot.where(
        entry_point_id: entry_point,
        rate: parking_rate,
        status: Slot::AVAILABLE
      ).first
    end
  end
end