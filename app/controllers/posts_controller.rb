class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def input_url

  end

  def crawl_url
    url = params[:src_url]
    res = HTTParty.get(url)
    text = Nokogiri::HTML(res.body)
    title = text.css('title').text
    body = text.css('body').text
    all = text.text

    kor = /^[가-힣a-zA-Z0-9]+$/
    all_text = text.text
    all = text.text.split(' ')

    # counter = WordsCounted.count(
    #     all_text
    #     )
    # fre = counter.token_frequency
    # puts fre

    word=Hash.new(0)

    all.each do |a|
        key = kor.match(a);
        unless key.nil?
            if word.has_key?(key)
                word[key]+=1
            else
                word.store(key,1)
            end
        end
    end
    word = word.sort_by{|k,v| v}.reverse.to_h;
    Post.create(
      title: title,
      src_url: params[:src_url],
      tag1: word.keys[0],
      tag2: word.keys[1],
      tag3: word.keys[2],
      desc: body
      )
    redirect_to root_path
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :src_url, :tag1, :tag2, :tag3, :desc)
    end
end
