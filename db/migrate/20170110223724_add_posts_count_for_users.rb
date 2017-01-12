class AddPostsCountForUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, null: false, default: 0
  end
end
