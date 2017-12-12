require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'


# key=["cafe.naver","cafe.daum","blog.naver","blog.daum","stackoverflow"]
# url = "http://m.blog.naver.com/jsjung1999/221152964968"
# url = "https://m.blog.naver.com/jsjung1999/221152964968"
# url = "https://blog.naver.com/jsjung1999/221152964968"
url = "http://blog.daum.net/pdi134/16122375"
# url = "http://m.blog.daum.net/shinbarksa/2369"
# url = "http://cafe.naver.com/appleiphone/4234984"
# url = "https://m.cafe.naver.com/PopularArticleRead.nhn?clubid=26872383&articleid=5926"
# url = "danceple.com"

def check_url(url)
  crawl_hash={
  #   Url name      => ["body name","tag name", "Mobile Mode"]
    "cafe.naver"    => ["#ct",nil,true],
    "cafe.daum"     => ["#daumWrap",nil,true],
    "blog.naver"    => [".se_component_wrap","list_tag",true],
    "blog.daum"     => ["#daumWrap",nil,true],
    "stackoverflow" => ["body",nil,false],
    "github" => ["body",nil,false],
    "brunch" => [".wrap_view_article",nil,false]
  }
  # # Initialize
  # crawl_tag = "body"
  # mobile_mode = false

  # p crawl_hash
  body_name = ""
  tag_name = ""
  mobile_mode = ""
  crawl_hash.each do |key, val|
    unless url[key].nil?
      # crawl_tag = val[0]
      # mobile_mode = val[1]
      # break;
      # p crawl_tag, mobile_mode
      body_name = val[0]
      tag_name = val[1]
      mobile_mode = val[2]
      # return val
    end
  end
  # puts body_name
  # puts tag_name
  # puts mobile_mode


  return ["body", nil, false]
end

# To do : When Mobile Mode add to "m." between "http://" and "url"

# mobile_mode
require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'


# key=["cafe.naver","cafe.daum","blog.naver","blog.daum","stackoverflow"]
# url = "http://m.blog.naver.com/jsjung1999/221152964968"
# url = "https://m.blog.naver.com/jsjung1999/221152964968"
# url = "https://blog.naver.com/jsjung1999/221152964968"
# url = "http://blog.daum.net/pdi134/16122375"
# url = "http://m.blog.daum.net/shinbarksa/2369"
# url = "http://cafe.naver.com/appleiphone/4234984"
# url = "https://m.cafe.naver.com/PopularArticleRead.nhn?clubid=26872383&articleid=5926"
url = "danceple.com"

def check_url(url)
  crawl_hash={
  #   Url name      => ["body name","tag name", "Mobile Mode"]
    "cafe.naver"    => ["#ct",nil,true],
    "cafe.daum"     => ["#daumWrap",nil,true],
    "blog.naver"    => [".se_component_wrap","list_tag",true],
    "blog.daum"     => ["#daumWrap",nil,true],
    "stackoverflow" => ["body",nil,false],
    "github" => ["body",nil,false],
    "brunch" => [".wrap_view_article",nil,false]
  }
  # # Initialize
  # crawl_tag = "body"
  # mobile_mode = false

  # p crawl_hash
  # body_name = ""
  # tag_name = ""
  # mobile_mode = ""
  crawl_hash.each do |key, val|
    unless url[key].nil?
      # crawl_tag = val[0]
      # mobile_mode = val[1]
      # break;
      # p crawl_tag, mobile_mode

      # body_name = val[0]
      # tag_name = val[1]
      # mobile_mode = val[2]
      return val
    end
  end
  # puts body_name
  # puts tag_name
  # puts mobile_mode


  return ["body", nil, false]
end

value = check_url(url)
puts value[0]
# To do : When Mobile Mode add to "m." between "http://" and "url"

# mobile_mode
# if mobile_mode
#   url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
# end
# puts url



# doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
# # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')
# doc.css('script').remove
# doc.xpath("//@*[starts-with(name(),'on')]").remove
# title = doc.css('title').text
# body = doc.css('body').text
# # crawl
# content = doc.css(body_name).text
# puts content
# # tag_name
#
#
#
#
# doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
# # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')
# doc.css('script').remove
# doc.xpath("//@*[starts-with(name(),'on')]").remove
# title = doc.css('title').text
# body = doc.css('body').text
# # crawl
# content = doc.css(body_name).text
# puts content
# tag_name
