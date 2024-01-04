class CreateComics < ActiveRecord::Migration[7.1]
  def change
    create_table :comics, id: :uuid do |t|
      t.datetime :publish_date, :null => false
      t.string   :title,        :null => false
      t.text     :description,  :null => false
      t.boolean  :is_published, :default => false

      t.timestamps
    end
  end
end
