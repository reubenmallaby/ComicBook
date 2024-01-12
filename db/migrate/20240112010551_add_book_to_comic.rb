class AddBookToComic < ActiveRecord::Migration[7.1]
  def change
    add_column :comics, :book_id, :uuid
  end
end
