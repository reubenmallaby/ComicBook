class Comic < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :publish_date, uniqueness: true 
  validates :image, presence: true

  scope :latest, -> { where(is_published: true).order(publish_date: :desc).first }
  scope :oldest, -> { where(is_published: true).order(publish_date: :asc).first }

  def self.years
    sql = "SELECT DISTINCT strftime('%Y', publish_date) y, COUNT(*) c FROM comics GROUP BY y ORDER BY y DESC"
    results = ActiveRecord::Base.connection.execute(sql)
    results
  end

  def self.months_for_year(year)
    year = year.to_i
    sql = "SELECT DISTINCT strftime('%m', publish_date) m, COUNT(*) c FROM comics WHERE strftime('%Y', publish_date) = '#{year}' GROUP BY m ORDER BY m DESC"
    results = ActiveRecord::Base.connection.execute(sql)
    results
  end

  def self.previous(date)
    return nil if date.blank?
    begin
      Comic.where(is_published: true).("publish_date < ?", date).order(publish_date: :desc).first
    rescue
      nil #404
    end
  end

  def self.next(date)
    return nil if date.blank?
    begin
      Comic.where(is_published: true).("publish_date > ?", date).order(publish_date: :asc).first
    rescue
      nil #404
    end
  end

  def self.find_by_date(date)
    return nil if date.blank?
    begin
      Comic.where(publish_date: date).first
    rescue
      nil #404
    end
  end

  def self.find_by_published_date(date)
    return nil if date.blank?
    begin
      Comic.where(publish_date: date, is_published: true).first
    rescue 
      nil #404
    end
  end
end
