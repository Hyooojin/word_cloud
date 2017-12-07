require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'open_uri_redirections'

url = "http://kkaok.tistory.com/1498"
# res = HTTParty.get(url)
# doc = Nokogiri::HTML(res.body)
doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
title = doc.css('title').text
body = doc.css('body').text
puts "===="
# puts body

all_text = ""
body.split("\n").each do |line|
  l = line.strip
  l.gsub!(/<\/?[^>]*>/, "")
  if(l.length > 0)
    # puts l
    all_text += l
  end
end
puts all_text