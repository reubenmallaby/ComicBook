class Comic < ApplicationRecord
  acts_as_taggable_on :tags

  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :publish_date, uniqueness: true 
  validates :image, presence: true

  scope :latest, -> { where(is_published: true).order(publish_date: :desc).first }
  scope :oldest, -> { where(is_published: true).order(publish_date: :asc).first }

  scope :previous, ->(date) { where('publish_date < ?', date).where(is_published: true).order(publish_date: :asc).limit(1) }
  scope :next, ->(date) { where('publish_date > ?', date).where(is_published: true).order(publish_date: :desc).limit(1) }

  def self.years
    sql = "SELECT DATE_PART('YEAR', publish_date)::int AS y, COUNT(id) AS c FROM comics GROUP BY y ORDER BY y DESC"
    results = ActiveRecord::Base.connection.execute(sql)
    results
  end

  def self.months_for_year(year)
    year = year.to_i
    sql = "SELECT DATE_PART('MONTH', publish_date)::int AS m, COUNT(id) AS c FROM comics WHERE DATE_PART('YEAR', publish_date)::int = #{year} GROUP BY m ORDER BY m DESC"
    results = ActiveRecord::Base.connection.execute(sql)
    results
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
