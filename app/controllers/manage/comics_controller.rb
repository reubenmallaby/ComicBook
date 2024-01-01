class Manage::ComicsController < Manage::BaseController
  before_action :get_comic, only: [:show_by_date, :edit, :destroy, :publish]
  before_action :get_comic_by_id, only: [:update]

  def index
    @years = Comic.years
  end

  def index_year
    @year = params[:year].to_i  || 2000
    @years = Comic.years

    @months = Comic.months_for_year @year
  end

  def index_month
    @year = params[:year].to_i  || 2000
    @years = Comic.years

    @month = (params[:month]    || 1).to_i
    @months = Comic.months_for_year @year

    start_date = DateTime.new @year, @month, 1
    @comics = Comic.where(publish_date: start_date.beginning_of_month..start_date.end_of_month).order(publish_date: :desc)
  end

  def new
    @comic = Comic.new
  end

  def show

  end

  def show_by_date
    @years = Comic.years

    @month = (params[:month]    || 1).to_i
    @months = Comic.months_for_year @year

    start_date = @comic.publish_date
    @comics = Comic.where(publish_date: start_date.beginning_of_month..start_date.end_of_month).order(publish_date: :desc)
  end

  def edit

  end

  def create
    @comic = Comic.new comic_params

    if @comic.save
      flash[:notice]= I18n.t("comic.saved_ok")
      date = @comic.publish_date
      redirect_to manage_comic_url(date.year, date.month, date.day)
    else
      flash[:alert]= I18n.t("comic.saved_error")
      render :new
    end
  end

  def update
    if @comic.update comic_params
      flash[:notice]= I18n.t("comic.updated_ok")
      date = @comic.publish_date
      redirect_to manage_comimc_url(date.year, date.month, date.day)
    else
      flash[:alert]= I18n.t("comic.updated_error")
      render :edit
    end
  end

  def publish
    @comic.is_published = !@comic.is_published
    if @comic.save
      flash[:notice]= I18n.t("comic.updated_ok")
    else
      flash[:alert]= I18n.t("comic.updated_error")
    end

    date = @comic.publish_date
    redirect_to manage_comics_for_month_url(date.year, date.month, date.day)
  end

  def destroy
    @comic.destroy

    flash[:notice]= I18n.t("comic.destroyed_ok")
    redirect_to manage_comics_url
  end

  private
  def get_comic
    @year = params[:year].to_i  || 2000
    @month = (params[:month]    || 1).to_i
    @day = (params[:day]        || 1).to_i

    begin
      @date = DateTime.new @year, @month, @day
    rescue
      @date = nil
    end
    logger.debug "DATE: #{@date}"

    @comic = Comic.find_by_date @date
    logger.debug "Comic? #{@comic.inspect}"

    raise ActionController::RoutingError.new('Comic Not Found') if @comic.blank?
  end

  def get_comic_by_id
    @comic = Comic.find params[:id]

    raise ActionController::RoutingError.new('Comic Not Found') if @comic.blank?
  end

  def comic_params
    params.require(:comic).permit(:title, :description, :publish_date, :is_published, :image)
  end
end