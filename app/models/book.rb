class Book < ApplicationRecord
  has_many :comics, dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true
end
