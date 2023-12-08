class ComicsController < ApplicationController

  def index
    @date = DateTime.new
    @comic = Comic.latest
    
    @first    = Comic.oldest.publish_date
    @previous = Comic.previous(@date)&.publish_date || nil
    @next     = nil
    @latest   = nil
  end

  def show
    year  = params[:year].to_i
    month = params[:month].to_i
    day   = params[:day].to_i
    @date = DateTime.new year, month, day
   
    @comic = Comic.find_by_published_date @date

    @first    = Comic.oldest&.publish_date          || nil
    @previous = Comic.previous(@date)&.publish_date || nil
    @next     = Comic.next(@date)&.publish_date     || nil
    @latest   = Comic.latest&.publish_date          || nil
    @latest   = nil if @latest == @first
  end
end
