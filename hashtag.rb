require 'httparty'
require 'nokogiri'


url = "https://m.blog.naver.com/sera8668/221159434304"
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

title = doc.css('title').text
body = doc.css('body').text

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

puts all_text.match(/(?<=[\s>]|^)#(\w*[A-Za-z_]+\w*)\b(?!;)/).to_s
# hashtag =  all_text.match(/(?<=[\s>]|^)#(\w*[A-Za-z_]+\w*)\b(?!;)/)
#   puts all_text[/(?<=[\s>]|^)#(\w*[A-Za-z_]+\w*)\b(?!;)/]
# end

# puts all_text
