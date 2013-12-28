class ArticlesController < ApplicationController

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD'], except: [:index, :show]

  # GET /articles
  def index
    page = if params[:page] then params[:page].to_i else 1 end
    @articles = Article.paginate({
      :order    => :created_at.desc,
      :per_page => 5,
      :page     => page
    })

    @older = @articles.count == 5 ? page + 1 : 0

    respond_to do |format|
      format.html
      format.json { render :json => @articles }
    end
  end

  def search
    tag = params[:tag]
    keyword = params[:keyword]

    if tag
      @articles = Article.where(:tag => Regexp.new(tag, 'i')).sort(:created_at.desc)
    elsif keyword
      @articles = Article.where(:title => Regexp.new(keyword, 'i')).sort(:created_at.desc)
    end

    respond_to do |format|
      format.html
      format.json { render :json => @articles }
    end
  end

  # GET /articles/new
  def new
  end

  # POST /articles
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, :notice => 'Article was successfully created.' }
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /articles/1
  def show
    @article = Article.first :urlrewrite => params[:id]
  end

  # GET /articles/1/edit
  def edit
    @article = Article.first :urlrewrite => params[:id]
    #render :edit, :layout => false
  end

  # PUT /articles/1
  def update
    @article = Article.first :urlrewrite => params[:id]

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, :notice => 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.first :urlrewrite => params[:id]
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

end
