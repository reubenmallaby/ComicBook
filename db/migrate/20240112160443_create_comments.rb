class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.uuid :user_id
      t.references :commentable, type: :uuid, polymorphic: true, null: false
      t.text :body

      t.timestamps
    end
  end
end
