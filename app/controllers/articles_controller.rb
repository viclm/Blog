class ArticlesController < ApplicationController

  def index
    p = if params[:page] then params[:page].to_i else 1 end
    @articles = Article.paginate({
      :order    => :created_at.desc,
      :per_page => 5,
      :page     => p
    })
    @older = @articles.size == 5 ? p + 1 : 0
  end

  def show
    @article = Article.first(:urlrewrite => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

end
