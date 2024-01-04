class ComicsController < ApplicationController
  def index
    @date = DateTime.new
    @comic = Comic.latest
    
    @first    = Comic.oldest
    @previous = Comic.previous(@date)
    @next     = nil
    @latest   = nil

    @years = Comic.years
  end

  def show
    @year  = params[:year].to_i
    @month = params[:month].to_i
    @day   = params[:day].to_i

    begin
      @date = DateTime.new @year, @month, @day
    rescue
      raise ActionController::RoutingError.new('Invalid date')
    end

    @years = Comic.years
    @months = Comic.months_for_year @year

    @comics = Comic.where(publish_date: @date.beginning_of_month..@date.end_of_month).order(publish_date: :desc)

    @comic = Comic.find_by_published_date @date
    @years = Comic.years

    @first    = Comic.oldest
    @previous = Comic.previous(@date)
    @next     = Comic.next(@date)
    @latest, @first = nil, nil       if @latest == @first
    @latest   = Comic.latest     unless @latest == @first
  end

  def for_year
    @year = params[:year].to_i  || 2000
    @years = Comic.years

    @months = Comic.months_for_year @year
  end

  def for_month
    @year = params[:year].to_i  || 2000
    @years = Comic.years

    @month = (params[:month]    || 1).to_i
    @months = Comic.months_for_year @year

    start_date = DateTime.new @year, @month, 1
    @comics = Comic.where(publish_date: start_date.beginning_of_month..start_date.end_of_month).order(publish_date: :desc)
  end
end
