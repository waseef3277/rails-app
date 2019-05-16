class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	before_action :require_user, only: [:edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to the blog #{@user.username}"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if !@user.authenticate(params[:user][:old_password])
			flash[:notice] = "Old Password does not match"
			render 'edit'
		elsif @user.update(user_params)
			flash[:notice] = "Password changed successfully"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 6)
	end

	def destroy
		@user.destroy
		flash[:notice] = @user.username + " and all of their articles, successfully deleted"
		redirect_to users_path
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :email, :avatar)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user and !current_user.admin?
			flash[:notice] = "You can not perform that action"
			redirect_to user_path(@user)
		end
	end

	def require_admin
		if !current_user.admin?
			flash[:notice] = "Only an Admin can delete a user"
			redirect_to users_path
		end
	end
end