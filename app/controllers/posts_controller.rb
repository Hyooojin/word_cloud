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
    #get_url
    url = @post.src_url
    array = ["google", "naver", "blog", "cafe", "c9", "github", "daum", "tistory"]
    findflag = false
    @re_url=""
    array.each do |arr|
        # puts arr
        if url.include? arr
            # puts arr
            if @re_url == 'private'
                @re_url =""
            end
            @re_url += arr
            @re_url += " "
            findflag = true
        else
            # puts "private"
            @re_url = "private" if !findflag
        end
    end
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
    doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
    title = doc.css('title').text
    body = doc.css('body').text

    all_text = ""
    body.split("\n").each do |line|
      l = line.strip
      l.gsub!(/<\/?[^>]*>/, "")
      if(l.length > 0)
        # puts l
        all_text += l
      end
    end

    processor = TwitterKorean::Processor.new
    # Noralize
    # twitter = processor.normalize(all_text)
    # Tokenize
    # twitter = processor.tokenize(all_text)
    # Stemming
    twitter = processor.stem(all_text)
    # extract pharases
    # twitter = processor.extract_phrases(all_text)
    # twitter = processor.extract_phrases(all_text).first.metadata

    # kor = /^[가-힣a-zA-Z0-9]+$/
    # word=Hash.new(0)
    # twitter.each do |t|
    #   key = kor.match(t);
    #   unless key.nil?
    #       if word.has_key?(key)
    #           word[key]+=1
    #       else
    #           word.store(key,1)
    #       end
    #   end
    # end
    # word = word.sort_by{|k,v| v}.reverse.to_h;

    # words_count
    word = Hash.new(0)
    twitter.each do |t|
      if word.has_key? t
        word[t] += 1
      else
        word.store(t, 1)
      end
    end
    word = word.sort_by {|k, v| v}.reverse.to_h
    # puts "================="
    # puts twitter.first.metadata.pos
    # puts "================="

    puts "================="
    puts word
    puts "================="

    Post.create(
      title: title,
      src_url: params[:src_url],
      tag1: word.keys[0],
      tag2: word.keys[1],
      tag3: word.keys[2],
      desc: params[:desc], #대략적인 설명
      html: "test", #all_text, # text | body
      words: "test" #twitter # NLP fuction 비교
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
