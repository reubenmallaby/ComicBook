class Manage::BooksController < Manage::BaseController
  before_action :get_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.order(order: :asc)
  end

  def show

  end

  def new
    @book = Book.new
  end

  def edit

  end

  def create
    @book = Book.new book_params

    if @book.save
      flash[:notice]= I18n.t("book.saved_ok")
      redirect_to manage_book_url(@book)
    else
      flash[:alert]= I18n.t("book.saved_error")
      render :new
    end
  end

  def update
    if @book.update book_params
      flash[:notice]= I18n.t("book.updated_ok")

      redirect_to manage_book_url(@book)
    else
      flash[:alert]= I18n.t("book.updated_error")
      render :edit
    end
  end

  def destroy
    flash[:notice]= I18n.t("book.destroyed_ok")
    redirect_to manage_books_url
  end

  private

  def get_book
    @book = Book.find params[:id]
  end

  def book_params
    params.require(:book).permit(:order, :title, :description)
  end
end
