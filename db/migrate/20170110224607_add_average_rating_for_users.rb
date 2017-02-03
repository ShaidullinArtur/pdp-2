class AddAverageRatingForUsers < ActiveRecord::Migration
  def change
    add_column :users, :average_rating, :float, null: false, default: 0.0
  end
end
