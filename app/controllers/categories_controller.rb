class CategoriesController < ApplicationController
before_action :set_category, only: [:edit, :update, :show]
before_action :require_user
before_action :require_admin



	def index
		@categories = Category.all
	end


	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category added successfully"
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @category.update(category_params)
			flash[:notice] = "Category updated successfully"
			redirect_to categories_path
		else
			render 'edit'
		end
	end

	def show
		if params[:term]
			@articles = @category.articles.where('title like ?', "%#{params[:term]}%").paginate(page: params[:page], per_page: 5)
		else
			@articles = @category.articles.paginate(page: params[:page], per_page: 5)
		end
	end


	private
	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.find(params[:id])
	end

	def require_admin
			if !current_user.admin?
			flash[:notice] = "Only ADMIN can perform that action"
			redirect_to articles_path
		end
	end

end