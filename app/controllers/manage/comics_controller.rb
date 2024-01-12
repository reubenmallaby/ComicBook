class Manage::ComicsController < Manage::BaseController
  before_action :get_comic_by_date, only: [:show_by_date]
  before_action :get_comic, only: [:edit, :update, :destroy, :publish]

  def index
    @years = Comic.years
    @tags = Comic.tag_counts_on(:tags)
    @current_date = DateTime.new
  end

  def index_year
    year = params[:year].to_i  || 2000
    @years = Comic.years
    @current_date = DateTime.new(year, 1, 1)

    @months = Comic.months_for_year year
    @tags = Comic.tag_counts_on(:tags)
  end

  def index_month
    year = params[:year].to_i  || 2000
    @years = Comic.years

    month = (params[:month]    || 1).to_i
    @current_date = DateTime.new(year, month, 1)

    @months = Comic.months_for_year @year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)
    @tags = Comic.tag_counts_on(:tags)
  end

  def new
    @comic = Comic.new
    @known_tags = known_tags
  end

  def show
    @tags = Comic.tag_counts_on(:tags)
  end

  def show_by_date
    @years = Comic.years

    @months = Comic.months_for_year @current_date.year

    @comics = Comic.where(publish_date: @current_date.beginning_of_month..@current_date.end_of_month).order(publish_date: :desc)
    @tags = Comic.tag_counts_on(:tags)
  end

  def edit
    @known_tags = known_tags
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

      redirect_to manage_comic_url(@comic)
    else
      flash[:alert]= I18n.t("comic.updated_error")
      render :edit
    end
  end

  def publish
    @comic.is_published = !@comic.is_published
    if @comic.save
      flash[:notice]= @comic.is_published ? I18n.t("comic.published_ok") : I18n.t("comic.hidden_ok")
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

  def tagged
    @tag = params[:tag]
    @comics = Comic.tagged_with(@tag).order(publish_date: :desc).limit(10)
    @max_count = Comic.tagged_with(@tag).count
  end

  private

  def get_comic_by_date
    year = params[:year].to_i  || 2000
    month = (params[:month]    || 1).to_i
    day = (params[:day]        || 1).to_i
    @current_date = DateTime.new(year, month, day)

    @comic = Comic.find_by_date @current_date

    not_found if @comic.blank?
  end

  def get_comic
    @comic = Comic.find params[:id]
    @current_date = @comic.publish_date

    not_found if @comic.blank?
  end

  def comic_params
    params.require(:comic).permit(:title, :description, :publish_date, :is_published, :image, :tag_list)
  end
end