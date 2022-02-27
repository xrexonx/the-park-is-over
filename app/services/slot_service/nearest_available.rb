module SlotService
  class NearestAvailable
    def self.run(entry_point, rate)
      Slot.where(
        entry_point_id: entry_point,
        rate: rate,
        status: Slot::AVAILABLE
      ).first
    end
  end
end