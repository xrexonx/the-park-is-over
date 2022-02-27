module DateService
  class CurrentDatetime
    def self.get
      datetime = DateTime.now
      datetime.strftime("%d/%m/%Y %H:%M")
      datetime
    end
  end
end
