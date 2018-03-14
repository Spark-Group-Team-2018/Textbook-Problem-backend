class User < ApplicationRecord

  has_many :pending_offers, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :textbooks, dependent: :destroy


end
