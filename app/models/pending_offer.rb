# Model relationships for Pending Offer model

class PendingOffer < ApplicationRecord
  belongs_to :offer
  belongs_to :buyer, :class_name => 'User'
end
