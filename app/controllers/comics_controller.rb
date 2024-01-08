class ComicsController < ApplicationController
  def index
    @current_date = DateTime.new
    @comic = Comic.latest
    
    @first    = Comic.oldest
    @previous = Comic.previous(@current_date)
    @next     = nil
    @latest   = nil

    @years = Comic.years
  end

  def show
    year  = params[:year].to_i
    month = params[:month].to_i
    day   = params[:day].to_i
    @current_date = DateTime.new(year, month, day)

    begin
      @date = DateTime.new year, month, day
    rescue
      raise ActionController::RoutingError.new('Invalid date')
    end

    @years = Comic.years
    @months = Comic.months_for_year year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)

    @comic = Comic.find_by_published_date @date
    @years = Comic.years

    @first    = Comic.oldest
    @previous = Comic.previous(@date)
    @next     = Comic.next(@date)
    @latest, @first = nil, nil       if @latest == @first
    @latest   = Comic.latest     unless @latest == @first
  end

  def for_year
    year = params[:year].to_i  || 2000
    @current_date = DateTime.new(year, 1, 1)

    @years = Comic.years
    @months = Comic.months_for_year year
  end

  def for_month
    year = params[:year].to_i  || 2000
    month = (params[:month]    || 1).to_i
    @current_date = DateTime.new(year, month, 1)

    @years = Comic.years
    @months = Comic.months_for_year year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)
  end
end
