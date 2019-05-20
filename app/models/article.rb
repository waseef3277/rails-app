class Article < ActiveRecord::Base
	has_many :article_categories, dependent: :destroy
	validates_presence_of :article_categories
	has_many :categories, through: :article_categories
	belongs_to :user
	has_many :comments
    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}
end