class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title, null: false
      t.string :subdomain, null: false, index: true

      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
