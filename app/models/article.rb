class Article < ActiveRecord::Base
	belongs_to :user
    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}
end