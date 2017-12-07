require 'httparty'
require 'nokogiri'
require 'open-uri'

url = "http://finance.naver.com/sise/"
# res = HTTParty.get(url)
text = Nokogiri::HTML(open(url),nil,'euc-kr')
tag = text.css('title').text
kor = /[가-힣]+/
all = text.text.split(' ')

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


puts word.keys[1]
