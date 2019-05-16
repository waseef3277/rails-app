class User < ActiveRecord::Base
	before_save {self.username = username.downcase}
	has_many :articles, dependent: :destroy
	validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5, maximum:20}
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 64} , :email_format => {message: "is not looking good"}
	has_secure_password
	has_attached_file :avatar, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end