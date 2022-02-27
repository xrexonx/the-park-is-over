module PaymentService
  class List
    def self.get
      Payment.all
    end
  end
end