class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    if params[:term].present? and params[:category].present?
      @articles = Article.joins(:categories).where('title like ? and category_id = ?', "%#{params[:term]}%", "#{params[:category]}").paginate(page: params[:page], per_page: 5)
    elsif params[:term].blank? and params[:category].present?
      @category = Category.find(params[:category])
      @articles = @category.articles  
    elsif params[:term].present? and params[:category].blank?
      @articles = Article.where('title like ?', "%#{params[:term]}%").paginate(page: params[:page], per_page: 5)
     # @articles = Article.where('title like ?', "%#{params[:term]}%").join().paginate(page: params[:page], per_page: 5)
    else
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article created successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end

  end

  def show

  end

  def edit

  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def destroy
    @article.destroy
    flash[:notice] = "Article deleted successfully"
    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :category_ids => [])
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:notice] = "You can not modify this article"
      redirect_to article_path(@article)
    end
  end



end