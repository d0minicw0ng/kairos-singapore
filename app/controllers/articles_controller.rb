class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    # @article = current_user.articles.build(params[:article])

    if @article.save
      flash[:notice] = t(:'articles.article_saved')
      redirect_to article_url(@article)
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end
end
