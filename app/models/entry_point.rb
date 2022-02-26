class EntryPoint < ApplicationRecord
  has_many :slots
  has_many :parkings
end
