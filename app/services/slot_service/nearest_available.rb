module SlotService
  class NearestAvailable
    def self.run(entry_point, vehicle_type)

      available_slots = find_available_slots([entry_point], vehicle_type)

      # if there is no available find in other entry points
      unless available_slots.any?
        entry_points = EntryPoint.where.not(id: entry_point).map(&:id)
        available_slots = find_available_slots(entry_points, vehicle_type)
      end

      available_slots.first
    end

    private
    def self.find_available_slots(entry_points, vehicle_type)
      slots = []
      entry_points.each do |entry_point|
        unless slots.any?
          avail_slots = EntryPoint
            .find_by_id(entry_point)
            .slots
            .where(status: Slot::AVAILABLE, rate: Parking::RATES[vehicle_type])
          slots.push(avail_slots.first)
        end
      end
      slots
    end
  end
end