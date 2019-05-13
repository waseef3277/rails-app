class User < ActiveRecord::Base
	before_save {self.username = username.downcase, self.email = email.downcase}
	has_many :articles
	validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5, maximum:20}
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 64} , :email_format => {message: "is not looking good"}
	has_secure_password
end