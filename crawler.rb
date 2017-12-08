require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'sanitize'


# url = "https://m.blog.naver.com/urimalo_/221119736323"
url = "http://kkaok.tistory.com/1498"
# res = HTTParty.get(url)
# doc = Nokogiri::HTML(res.body)
doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
doc.css('script').remove
# puts "====js====="
# # puts doc
# doc.xpath("//@*[starts-with(name(), 'on')]").remove
doc.xpath("//@*[starts-with(name(),'on')]").remove
# doc.gsub!(/<\s*script\s*>|<\s*\/\s*script\s*>/, '')
# puts doc
title = doc.css('title').text
body = doc.css('body').text
puts "========="
puts doc
puts "======"
puts title
puts "===="
puts body


all_text = ""
body.split("\n").each do |line|
  l = line.strip
  l.gsub!(/<\/?[^>]*>/, "")
  if(l.length > 0)
    # puts l
    all_text += l
  end
end
# puts all_text

processor = TwitterKorean::Processor.new
# twitter = processor.tokenize(all_text)
# Tokenize
# twitter = processor.tokenize(all_text)
# Stemming
 twitter = processor.stem(all_text)
# puts twitter

puts "====="
# puts twitter
