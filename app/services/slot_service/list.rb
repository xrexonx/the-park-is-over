module SlotService
  class List
    def self.get
      Slot.all
    end
  end
end