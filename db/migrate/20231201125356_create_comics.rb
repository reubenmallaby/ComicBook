class CreateComics < ActiveRecord::Migration[7.1]
  def change
    create_table :comics do |t|
      t.datetime :publish_date, :null => false
      t.string :title,          :null => false, :default => "Name me"
      t.text :description,      :null => false, :default => "Describe me"
      t.boolean :is_published,  :default => false    

      t.timestamps
    end
  end
end
