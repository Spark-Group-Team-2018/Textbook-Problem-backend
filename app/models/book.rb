class Book < ApplicationRecord
  belongs_to :manufacturer

  has_many :textbooks, dependent: :destroy
  has_many :wishlists, dependent: :destroy

end
