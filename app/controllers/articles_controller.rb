class ArticlesController < ApplicationController

  before_filter :authenticate_user!

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(params[:article])

    if @article.save
      flash[:notice] = t(:'articles.article_saved')
      redirect_to article_url(@article)
    else
      render :new
    end
  end

  def show
    @article = Article.includes(comments: :user).find(params[:id])
    @comment = Comment.new
  end
end
