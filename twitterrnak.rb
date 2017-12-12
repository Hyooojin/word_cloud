require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'
require 'httparty'
require 'narray'


# def crawl_url
  # url = http://bomi.kro.kr/221155020279
  # url = "http://blog.naver.com/hannapride/221139438834"
  # url = "http://cafe.naver.com/ifogta/12920"
  url = "http://blog.naver.com/gobogi1102/221077362992"
  # url = "http://m.blog.daum.net/mtholic/8113342"
  # url = "https://brunch.co.kr/@kmbmjn95/23"
  # url = "http://100.daum.net/encyclopedia/view/87XX40000411"
  # url = "http://coinfor.tistory.com/228"
  # url = "http://cafe.daum.net/subdued20club/LxCT/219129?q=%B9%CC%B1%B9%20%BF%A9%C7%E0"
  # url = "http://cafe.daum.net/ASMONACOFC/gAVU/667796?q=%B9%CC%B1%B9%20%BF%A9%C7%E0"
  # url = "http://vogue694.tistory.com/270"
  # url = "http://keijapan.tistory.com/988" # 일상 내용이 많이 담겨있음 tag
  # url = "http://krtiptiptip.tistory.com/695"
  if url.include? 'blog.naver' or url.include? 'blog.daum' or url.include? 'cafe.naver' or url.include? 'cafe.daum'
    url = "#{url[0,7]}m.#{url[7..-1]}"
  end
  doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
  # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')

  doc.css('script').remove
  doc.xpath("//@*[starts-with(name(),'on')]").remove

  tag_label = Array.new
  if url.include?('blog.naver')
    title = doc.css('h3.se_textarea').text
    body = doc.css('.__se_component_area').text
    #ct > div._postView naver.blog 전체(tag부분 포함하는 body)
    # 본문 content만 긁어오자 하는 경우 tag를 twitter를 이용해서 가져 올 수 없음.  tag부분을 포함하고자 하는 경우에는 밑의 다른 post list와 앱 설치 유도 등의 부분 정보까지 가져와야 함.
    tag_label = doc.css('.post_tag').text
  elsif url.include?('cafe.naver')
    title = doc.css('h2.tit').text
    body = doc.css('#postContent').text
  elsif url.include?('tistory')
    title = doc.css('.titleWrap').text
    tag_label = doc.css('.tag_label').text
    #main > div.contents > div.entry > div.article > div.tt_article_useless_p_margin
    body = doc.css('#body > div.article > div > div').text
  elsif url.include?('blog.daum')
    title = doc.css('#daumContent > div.view_head > h3').text
    body = doc.css('#article').text
  else
    title = doc.css('title').text
    body = doc.css('body').text
  end
  puts title
  puts tag_label

  # puts body
  # processor = TwitterKorean::Processor.new
  # twitter = processor.normalize(body)
  # puts twitter

#   all_array = Array.new
#   all_text = ""
#   body.split("\n").each do |line|
#     l = line.strip
#     if(l.length > 0)
#       all_text += l + " "
#       # all_array << TfIdfSimilarity::Document.new(l)
#       all_array << l
#     end
#   end
#
#   puts all_array[110]
#   processor = TwitterKorean::Processor.new
#   twitter = Array.new
#   all_array.each do |arr|
#     twitter << processor.stem(arr)
#     # puts twitter
#   end
#   # puts twitter[0].class # 2dimension array
#   # puts twitter[0][0].class # TwitterKorean::KoreanToken
#
#   idf = Array.new
#   twitter.each do |t|
#     t.each do |str|
#       str.join(" ")
#       puts str
#     # idf << TfIdfSimilarity::Document.new(t)
#     end
#   end
#
#   # puts idf[0] # 생성 성공...?
#   # model = TfIdfSimilarity::TfIdfModel.new(idf, :library => :narray)
#   #
#   # tfidf_by_term = {}
#   # idf.each do |i|
#   #   i.terms.each do |t|
#   #     tfidf_by_term[i] = model.tfidf(i, t)
#   #   end
#   # end
#   # tf = tfidf_by_term.sort_by{|_,tfidf| -tfidf}
#
#   # word = Hash.new(0)
#   # twitter.each do |t|
#   #   if word.has_key? t
#   #     word[t] += 1 if t.metadata.pos == :noun
#   #   else
#   #     word.store(t, 1) if t.metadata.pos == :noun
#   #   end
#   # end
# #
# #   word = word.sort_by {|k, v| v}.reverse.to_h
# #   puts "========================="
# #   puts "#{word.keys[0]} || #{word.keys[1]} || #{word.keys[2]}"
# #
# #   puts "url : #{url}"
# #   puts "title : #{title}"
# #   puts "hashtag : #{tag_label}"
# #   # puts "body : #{body}"
# #
# #
# # #
# # #   all_array << TfIdfSimilarity::Document.new(title)
# # #   model = TfIdfSimilarity::TfIdfModel.new(all_array, :library => :narray)
# # #   # matrix = model.similarity_matrix
# # #
# # #   tfidf_by_term = {}
# # #   all_array.each do |i|
# # #     i.terms.each do |t|
# # #       tfidf_by_term[t] = model.tfidf(i, t)
# # #     end
# # #   end
# # #
# # #   tf = tfidf_by_term.sort_by{|_,tfidf| -tfidf}
# # #
# # #   tag1 = tf[-1][0]
# # #   tag2 = tf[-2][0]
# # #
# # #
# # #
# # #
# # #
# # # end
