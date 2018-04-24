# Model relationships for Offer model

class Offer < ApplicationRecord
  belongs_to :textbook

  has_many :pending_offers, dependent: :destroy

end
