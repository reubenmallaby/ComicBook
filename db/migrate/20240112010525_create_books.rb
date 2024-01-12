class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books, id: :uuid do |t|
      t.integer :order, default: 1, null: false
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
