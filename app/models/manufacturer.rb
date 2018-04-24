# Model relationships for Manufacturer model

class Manufacturer < ApplicationRecord
  has_many :books
end
