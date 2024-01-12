class BooksController < ApplicationController
  def index
    @current_date = DateTime.new
    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years
    @books = Book.all.order(order: :desc)
  end

  def show
    @current_date = DateTime.new
    @tags = Comic.tag_counts_on(:tags)
    @years = Comic.years
    @book = Book.find params[:id]
  end
end
