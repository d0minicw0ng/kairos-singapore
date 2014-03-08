class ArticlesController < ApplicationController

  before_filter :authenticate_user!

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:notice] = t(:'articles.article_saved')
      redirect_to article_url(@article)
    else
      render :new
    end
  end

  def show
    @article = Article.includes(comments: :user).friendly.find(params[:id])
    @image = Image.where(imageable_type: 'Article', imageable_id: @article.id).limit(1).try(:first)
    @comment = Comment.new
  end

  def edit
    @article = Article.friendly.find(params[:id])
  end

  def update
    @article = Article.friendly.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = t(:'articles.article_updated')
      redirect_to article_url(@article)
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id, images_attributes: [:avatar])
  end
end
