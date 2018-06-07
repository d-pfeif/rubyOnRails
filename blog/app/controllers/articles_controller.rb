class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # returns ApplicationController object with paramaters being passed
    # render plain: params[:article].inspect

    # creates a new Article. Ruby exhibits various security features that require explicit parameters (in this case :title and :text) to avoid any malicious intent from a user.
    # @article = Article.new(params.require(:article).permit(:title, :text))

    # Alternatively, the safest way to secure your program is to create a private variable that contains the parameters and pass that into the new Article
    @article = Article.new(article_params)

    # saves Article to database if validated
    if @article.save
      #redirects to /articles
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy
    redirect_to articles_path
  end

  # private section should be at the end of the class
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
