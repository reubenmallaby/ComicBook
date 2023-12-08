class CreateComics < ActiveRecord::Migration[7.1]
  def change
    create_table :comics do |t|
      t.datetime :publish_date
      t.string :title
      t.text :description
      t.boolean :is_published, :default => false    

      t.timestamps
    end
  end
end
