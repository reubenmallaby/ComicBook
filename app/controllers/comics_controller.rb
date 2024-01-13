class ComicsController < ApplicationController
  def index
    @current_date = DateTime.new
    @comic = Comic.latest
    
    @first    = Comic.oldest
    @previous = Comic.previous(@current_date)
    @next     = nil
    @latest   = nil

    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years
  end

  def show
    year  = params[:year].to_i
    month = params[:month].to_i
    day   = params[:day].to_i

    begin
      @current_date = DateTime.new(year, month, day)
    rescue
      raise ActionController::RoutingError.new('Invalid date')
    end

    @years = Comic.years
    @months = Comic.months_for_year year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)

    @comic = Comic.find_by_published_date @current_date
    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years

    @first    = Comic.oldest
    @previous = Comic.previous(@current_date).first
    @next     = Comic.next(@current_date).first
    @latest, @first = nil, nil       if @latest == @first
    @latest   = Comic.latest     unless @latest == @first
  end

  def for_year
    year = params[:year].to_i  || 2000
    @current_date = DateTime.new(year, 1, 1)

    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years
    @months = Comic.months_for_year year
  end

  def for_month
    year = params[:year].to_i  || 2000
    month = (params[:month]    || 1).to_i
    @current_date = DateTime.new(year, month, 1)

    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years
    @months = Comic.months_for_year year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)
  end

  def tagged
    @tag = params[:tag]
    @tags = Comic.tag_counts_on(:tags)
    @current_date = DateTime.new
    @years = Comic.years
    @months = Comic.months_for_year @current_date.year
    @comics = Comic.tagged_with(@tag).order(publish_date: :desc).limit(10)
    @max_count = Comic.tagged_with(@tag).count
  end

  def comment
    @comic = Comic.find params[:id]
    @comment = @comic.comments.build comment_params
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html do
          d = @comic.publish_date
          redirect_to comic_path(d.year, d.month, d.day)
        end
        format.js { render partial: 'shared/comment' }
      end
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
