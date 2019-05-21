class CreateArticleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :article_categories do |t|
    	t.references :articles
    	t.references :categories

    	t.timestamps 
    end
  end
end
