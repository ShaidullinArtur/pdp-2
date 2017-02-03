class CreateCompanyPosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :company, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :title, null: false
      t.text :text, null: false
      t.float :rating, null: false, default: 0.0

      t.timestamps null: false
    end
  end
end
