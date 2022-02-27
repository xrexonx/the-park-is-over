module ParkingService
  class List
    def self.get
      Parking.all
    end
  end
end