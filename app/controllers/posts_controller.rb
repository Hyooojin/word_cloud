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

    m_url = ["naver", "daum"] # m_url[i]
    m_url.each do |m|
      if url.include? m
        url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
      end
      # puts m
    end




    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end
    response = HTTParty.get(url)
    doc = Nokogiri::HTML(response.body)


    # m.blog.naver.com/kaite1130/221151754855
    # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
    # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')
    doc.css('script').remove
    doc.xpath("//@*[starts-with(name(),'on')]").remove


    # URL
    # url.match()



    title = doc.css('title').text
    body = doc.css('body').text
    # body.gsub!(/<\s*script\s*>|<\s*\/\s*script\s*>/, '')

    all_array = Array.new
    all_text = ""
    body.split("\n").each do |line|
      l = line.strip
      # l.gsub!(/<\/?[^>]*>/, "")
      if(l.length > 0)
        # puts l
        all_text += l + " "
        all_array << l
      end
    end

    # all_text.gsub(/<\s*script\s*>|<\s*\/\s*script\s*>/, '')


    # twitter NLP
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


    # hashtag
    metadata = Array.new
    twitter.each do |t|
      metadata << t if t.metadata.pos == :hashtag # t.metadata
      # puts t.metadata
    end



    # words_count
    word = Hash.new(0)
    twitter.each do |t|
      if word.has_key? t
        word[t] += 1 if t.metadata.pos == :noun # :hasttag
      else
        word.store(t, 1) if t.metadata.pos == :noun
      end
    end
    word = word.sort_by {|k, v| v}.reverse.to_h
    puts "====="
    puts word
    # puts "================="
    # puts twitter.first.metadata.pos
    # puts "================="

    # puts "================="
    # puts word
    # puts "================="



    Post.create(
      title: title,
      src_url: params[:src_url],
      tag1: word.keys[0],
      tag2: word.keys[1],
      tag3: word.keys[2],
      desc: params[:desc], #대략적인 설명
      html: all_array, #all_text, # all_arra y# text | body
      words: metadata #word twitter # word # NLP fuction 비교
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
