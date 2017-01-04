class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true, foreign_key: true
      t.belongs_to :user, index: true
      t.text :text, null: false

      t.timestamps null: false
    end
  end
end
