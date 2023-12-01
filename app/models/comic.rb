class Comic < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :publish_date, uniqueness: true
end
