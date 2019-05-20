class CommentsController < ApplicationController

def create
	@article = Article.find(params[:article_id])
	if logged_in
		@comment = @article.comments.create(params[:comment].permit(:content))
		@comment.user = current_user
		if @comment.save
			redirect_to article_path(@article)
		end
	end
end

def destroy
	@article = Article.find(params[:article_id])
	@comment = @article.comments.find(params[:id])
	if @article.user == current_user or @comment.user == current_user
		@comment.destroy
		redirect_to article_path(@article)
	end
end


end