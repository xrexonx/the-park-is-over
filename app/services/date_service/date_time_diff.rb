module DateService
  class DateTimeDiff
    def self.get(start_date, end_date)
      diff = ((end_date - start_date) / 1.hour)
      (diff.to_f).ceil
    end
  end
end
