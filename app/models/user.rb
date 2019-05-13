class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5, maximum:20}
	validates :email, presence: true, uniqueness: {case_sensitive: false}, :email_format => {message: "is not looking good"}
end