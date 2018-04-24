# Model relationships for Textbook model

class Textbook < ApplicationRecord
  belongs_to :book
  belongs_to :user

  has_many :offers, dependent: :destroy

end
