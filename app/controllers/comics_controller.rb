class ComicsController < ApplicationController

  def index
    @date = DateTime.new
    @comic = Comic.latest
    
    @first    = Comic.oldest.publish_date
    @previous = Comic.previous(@date)
    @next     = nil
    @latest   = nil
  end

  def show
    year  = params[:year].to_i
    month = params[:month].to_i
    day   = params[:day].to_i

    begin
      @date = DateTime.new year, month, day
    rescue
      raise ActionController::RoutingError.new('No comic on date given')
    end

    @comic = Comic.find_by_published_date @date

    @first    = Comic.oldest
    @previous = Comic.previous(@date)
    @next     = Comic.next(@date)
    @latest, @first = nil, nil       if @latest == @first
    @latest   = Comic.latest     unless @latest == @first
  end
end
