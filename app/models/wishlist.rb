# Model relationship for wishlist
# TODO implement into application later on

class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
