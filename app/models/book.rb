class Book < ApplicationRecord
  belongs_to :manufacturer

  has_many :textbooks
  has_many :wishlists

end
