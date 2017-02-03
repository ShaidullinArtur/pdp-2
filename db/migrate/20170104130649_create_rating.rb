class CreateRating < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :post, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true

      t.float :value, null: false, default: 0.0

      t.timestamps null: false
    end
  end
end
