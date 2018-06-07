class ArticlesController < ApplicationController
  def new
  end

  def create
    # returns ApplicationController object with paramaters being passed
    # render plain: params[:article].inspect

    # creates a new Article. Ruby exhibits various security features that require explicit parameters (in this case :title and :text) to avoid any malicious intent from a user.
    # @article = Article.new(params.require(:article).permit(:title, :text))

    # Alternatively, the safest way to secure your program is to create a private variable that contains the parameters and pass that into the new Article
    @article = Article.new(article_params)


    # saves Article to database
    @article.save

    #redirects to /article
    redirect_to @article
  end

  def show
    @article = Article.find(params[:id])
  end


  # private section should be at the end of the class
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
