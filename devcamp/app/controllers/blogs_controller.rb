class BlogsController < ApplicationController
  #privateにbefore_actionが定義されていて、同じコードを書く必要がないようにあらかじめ定義しておく。
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
	#@blogs = Blog.limit(1)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
	#showメソッドで呼び出されているのは実際には以下のコードである。
	#@blog = Blog.find(params[:id])
	#@blog = Blog.find(2)
  end

  # GET /blogs/new
  def new
	#何もはいっていない値を入れる
	#new.html.erbではformへレンダリグされてそこで値を入力する
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
  　　#blog_paramsとは？
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
	    #format.htmlでブラウザで利用できるようにする。
        format.html { redirect_to @blog, notice: 'Your post is now live.' }
        #上と同じ内容→format.html { redirect_to blog_path(@blog), notice: 'Blog was successfully created.' }
        #format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        #format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Post was removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
	　　#データべースで使えるようになる。呼び出して使う。
      params.require(:blog).permit(:title, :body)
    end
end
