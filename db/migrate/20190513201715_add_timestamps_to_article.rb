class AddTimestampsToArticle < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :created_at, :datetime
  	add_column :articles, :updated_at, :datetime

  	change_column_null :articles, :created_at, false
  	change_column_null :articles, :updated_at, false
  end
end
