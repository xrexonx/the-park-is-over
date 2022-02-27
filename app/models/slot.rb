class Slot < ApplicationRecord
  belongs_to :entry_point
  belongs_to :parking

  AVAILABLE = 'green'.freeze
  OCCUPIED = 'red'.freeze

end
