class Slot < ApplicationRecord
  belongs_to :entry_point
  belongs_to :parking, optional: true

  AVAILABLE = 'green'.freeze
  OCCUPIED = 'red'.freeze

end
