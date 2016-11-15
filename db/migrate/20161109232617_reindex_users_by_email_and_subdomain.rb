class ReindexUsersByEmailAndSubdomain < ActiveRecord::Migration
  def up
    remove_index :users, :email
    add_index :users, %i(email subdomain), unique: true
  end

  def down
    remove_index :users, %i(email subdomain)
  end
end
