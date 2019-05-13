class AddTimestampsToArticle < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :created_at, :datetime
  	add_column :articles, :updated_at, :datetime

  	change_column :articles, :created_at, :datetime, null: false
  	change_column :articles, :updated_at, :datetime, null: false
  end
end
