require 'active_support'
require 'rubygems'
require 'domainatrix'

# url = "https://m.blog.naver.com/sera8668/221159434304"
url = "http://navercast.naver.com/magazine_contents.nhn?rid=1639&contents_id=139016"
# url = "https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there"
# url = "http://www.loc.gov/standards/mods/v3/mods-3-0.xsd"
# url = "http://www.test.com/dir/filename.jpg?var1=foo#bar"
# url = "https://blog.naver.com/sera8668/221159434304"
# url = "http://m.blog.daum.net/mtholic/8113342"
# url = "not url"
# url_re = /^((http[s]?|ftp):)\/)?/

url = Domainatrix.parse(url)
# puts url.domain + url.subdomain
re_url= url.subdomain + url.domain
puts re_url.class
re_url.gsub!(/(m.|www)/, '')
puts re_url

# puts url.subdomain

# puts url.split(/\/\//)[1]
# url_body = url.split(/\/\//)[1]
# puts url_body.split(/\//)[0].sub(/(m.|.com|www.)/,'')
# m_url = ["naver", "daum"] # m_url[i]
# m_url.each do |m|
#   if url.include? m
#     url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
#   end
#   # puts m
# end


# m 붙이기
# re_url = url.gsub("https://")
# puts re_url.to_s

# puts url.partition("//")[1], url.partition("//")
# url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )

# url.include? "naver"
# url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )

# puts m_url[0]
#
# m_url = ["naver", "daum"]
# # if url.include? naver
# #   url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
# # end

# (1) url을 확인한다. true false로 m에 대한 과정을 거치지 않도록
# (2) naver나 daum이 있으면,
# (3) m을 이후 붙인다.


# active = "lo".in?("hello")
# puts active
# "naver".in?("naverblog")
#   puts url
# end
# "naver".in?(url)
#   puts url
# end

# url.in?(['naver', 'daum'])
#   puts url
# end


# m_url = ["naver", "daum"]
# m_url.each do |m|
#   if url.include? m
#     url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
#   end
#   # puts m
# end
#
#
# puts url


# i = 0
# if url.include? m_url[i]
#
# end


# puts url.partition("//")[1]+"m."
#
# re_url = url.gsub(url.partition("//")[1], url.partition("//")[1]+"m." )
# puts re_url


# url.gsub(/^http[s]/, /^http[s]/)
# re_url = url.partition("//").gsub(url.partition("//").)
# # puts re_url[-1]
# re_url = re_url[1] + ("m.")
# puts re_url


# re_url = ""
# url.partition("//").each do |re|
#    re[1] = re[1]+("m.")
#    puts re
# end






# 정규표현식

# re_url = url_re.match(url)
# puts re_url
# puts url.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/)
# puts url.match(/((http[s]?|ftp):\/)?\/?/)
# puts url.match(/[:\/\w]+/)
# puts url.match(/(\/\w+)*\//)
# puts url.match(/[\w\-\.]+/)
# puts url.match(/[^#?\s]+/)
# puts url.match(/.*/)
# puts url.match(/\-/)
# puts url.match(/#[\w\-]+/)
# puts url.match(/\/[\w\-]+/)


# /기준으로 나누기
# puts url.split("/")


# http:// 부터 .com까지만 가져오기
# puts url.match(/http[s]?:\/\/?[^:\/\s]+/)
# puts url.match(/[\/]/) # /
# puts url.match(/[\/]+/) #//
# puts url.match(/[^\/]+/) #http:



##### //부터 뽑기
# puts url.match(/([\/]+)/) # //
# // 혹은 www 부터 .com 사이만 가져오기

# puts url.match(/([\/]+)(?:\w+(?::\s*)?@)?(?:(?!10(?:\.\d{1,3}){3}))/)
# url = "https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there"

# puts url.match(/\A(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?\z/)
# m,s ...

## 만약 .이 있으면

# [] pattern
sysntax = "gray"
puts sysntax.match(/[ae]/)
sysntax = "reign"
puts sysntax.match(/([^aei]+[^aei])/)



# url.each do |re|
#   puts re.split("/")
#   # puts re.match(/\/[\w\-]+/)
# end



# puts url.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/)

# puts url.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)$/)

# string = "My phone number is (123) 555-1234."
# phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
# m = phone_re.match(string)





#1. /a/
# -> a
#2. /\?/
# -> The backslash means "don't treat the next character as special; treat it as itself."
# The special characters include ^, $, ? , ., /, \, [, ], {, }, (, ), +, and *.
#3. /.naver/ A dot matches any charactr with the exception of a newline.
# /navercast -> /naver
# .naver.com -> .naver
#4 /[dr]naver/ dnavr or rnaver
#5 /[a-z]/
# -> h
#6 /[A-Fa-f0-9]/
# -> This matches any character a through f (upper- or lowercase) or any digit.
#7 /[^A-Fa-f0-9]/
# -> you put a caret (^) at the beginning of the class. Here's the character class that matches any character except a valid hexadecimal digit:
# [^o-o] o-o안에 숫자를 제외하고 일치하는 글자
# 8 \[0-9]\  /  \d
# /[0-9]/
# useful escape sequences
# \w는 임의의 숫자, 알파벳 문자 또는 밑줄(_)과 일치
# \s는 공백 문자와 일치
# 부정형 /\D/
# /a/.match("b") nil
# puts /a/.match("b")

# 9   여러문자
# string = "My phone number is (123) 555-1234."
# phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
# m = phone_re.match(string)

#10 /(http[s])/
# https

# 11 /(http[s]?)/ https를 돌려도 http를 돌려도 된다.
# https, http


# 12 /(http[s]?|ftp)/
# https, http

# 13 /(http[s]?|ftp):/           /((http[s]?|ftp):\/)/
# https: http:

# 14 /(http[s]?|ftp):\//
# https:/ , http:/

# 15. /:\//
# -> :/

# 16. /[:\/\s]/
# -> :
# 17. /[:\/\s]+/
# -> ://
# 18. /[:\/\w]+/
# https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
# -> https://stackoverflow
# http://www.test.com/dir/filename.jpg?var1=foo#bar
# -> http://www

# 19. /\/\w/
# https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
# -> /s
# http://www.test.com/dir/filename.jpg?var1=foo#bar
# -> /w


# 20. /\/\w+/
# http://www.test.com/dir/filename.jpg?var1=foo#bar
# -> /www
# https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
# -> /stackoverflow

# 21. /(\/\w+)*\// 이건 왜 다시 / 나오지?
# -> /

# 22. /[\w\-\.]/
# -> h


# 23. /[\w\-\.]+/
# -> https , http

# 24. /[^#?\s]+/
# -> 이거하면 다 나오던데?
# http://www.test.com/dir/filename.jpg?var1=foo#bar
# http://www.test.com/dir/filename.jpg
# https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
# https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
# ?에서 못 받아옴.

# 25. /.*/
# http://www.test.com/dir/filename.jpg?var1=foo#bar
# http://www.test.com/dir/filename.jpg?var1=foo#bar


# 26 # 뒤에 문자  /#[\w\-]/
# #b
