class Comic < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :publish_date, uniqueness: true 

  scope :latest, -> { where(is_published: true).order(publish_date: :desc).first }
  scope :oldest, -> { where(is_published: true).order(publish_date: :asc).first }

  def self.previous date
    begin
      Comic.where(is_published: true).("publish_date < ?", date).order(publish_date: :desc).first
    rescue
      nil #404
    end
  end

  def self.next date
    begin
      Comic.where(is_published: true).("publish_date > ?", date).order(publish_date: :asc).first
    rescue
      nil #404
    end
  end

  def self.find_by_published_date date
    begin
      logger.info "????? #{Comic.where(publish_date: date, is_published: true)}"
      Comic.where(publish_date: date, is_published: true).first
    rescue 
      nil #404
    end
  end
end
