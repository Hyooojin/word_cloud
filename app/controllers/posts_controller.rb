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

    value = check_url(url) # return "body name","tag name", "Mobile Mode"
    body_name = value[0]
    tag_name = value[1]
    mobile_mode = value[2]
    puts body_name
    puts tag_name
    puts mobile_mode

    # #checking url
    # If there is no http://
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end
    #mobile_mod check
    if mobile_mode
      url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
    end

    # #crawling
    response = HTTParty.get(url)
    doc = Nokogiri::HTML(response.body)
    # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
    # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')

    # remove
    doc.css('script').remove
    doc.xpath("//@*[starts-with(name(),'on')]").remove

    # select body
    title = doc.css('title').text
    body = doc.css('body').text
    content = doc.css(body_name).text
    # body.gsub!(/<\s*script\s*>|<\s*\/\s*script\s*>/, '')

    # just tag
    tag = doc.css(tag_name).text


    all_array = Array.new
    # all_text = content.split(".")
    content = content.gsub("  ","")
    all_text = content.split(/[\?\!\.;]+/)
    p '*******************'
    p content
    all_text.length.times do |i|
      l = all_text[i].strip
      # l.gsub!(/\s+/, "")
      if(l.length > 0)
        # puts l
        all_text[i] = l
        # all_array << l
      end
    end
p '~~~~~~~~~~~~~~~~~~~~~~'
    p all_text
    # all_text.gsub(/<\s*script\s*>|<\s*\/\s*script\s*>/, '')


    # twitter NLP
    processor = TwitterKorean::Processor.new
    # Noralize
    # twitter = processor.normalize(all_text)
    # Tokenize
    # twitter = processor.tokenize(all_text)
    # Stemming
    twitter = Array.new
    all_text.each do |s|
      twitter << processor.stem(s)
    end

    p twitter
    p tag
    p '======================'
    # extract pharases
    # twitter = processor.extract_phrases(all_text)
    # twitter = processor.extract_phrases(all_text).first.metadata


    # hashtag
    metadata = Array.new
    twitter.length.times do |i|
      twitter[i].each do |t|
        metadata << t if t.metadata.pos == :hashtag # t.metadata
        # puts t.metadata
      end
    end


    # words_count
    word = Hash.new(0)
    twitter.length.times do |i|
      twitter[i].each do |t|
        if word.has_key? t
          word[t] += 1 if t.metadata.pos == :noun # :hasttag
        else
          word.store(t, 1) if t.metadata.pos == :noun
        end
      end
    end
    word = word.sort_by {|k, v| v}.reverse.to_h
    # puts "====="
    # puts word
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
      html: all_text, #all_text, # all_arra y# text | body
      words: word #word twitter # word # NLP fuction 비교
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

    def check_url(url)
      crawl_hash= {
        "cafe.naver"    => ["#ct",nil,true],
        "blog.naver"    => [".se_component_wrap",".post_tag",true],
        "cafe.daum"     => ["#daumWrap",nil,true],
        "blog.daum"     => ["#article","#tagListLayer_11777182",true],
        "stackoverflow" => ["#mainbar",nil,false],
        "github"        => ["#readme","body",false],
        "brunch"        => [".wrap_view_article",nil,false]
      }

      def_val = ["body",nil,false] # crawl_hash에 지정되어 있지 않은 도메인의 url

      # "body name","tag name", "Mobile Mode"
      crawl_hash.each do |key, val|
        p val[1]
        p val[2]
        unless url[key].nil?
          val[-1] = false unless url["/m."].nil?
          #key가 crawo_hash에 있는 경우, key에 해당하는 val값이 return
          p val
          return val
        end
      end

      return def_val
    end
end
