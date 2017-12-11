# url = "https://m.blog.naver.com/sera8668/221159434304"
# url = "http://navercast.naver.com/magazine_contents.nhn?rid=1639&contents_id=139016"
# url = "https://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there"
# url = "http://www.loc.gov/standards/mods/v3/mods-3-0.xsd"
url = "http://www.test.com/dir/filename.jpg?var1=foo#bar"
# url = "not url"
# url_re = /^((http[s]?|ftp):)\/)?/

# re_url = url_re.match(url)
# puts re_url
puts url.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/)
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
puts url.split("/")


# http:// 부터 .com까지만 가져오기
# // 혹은 www 부터 .com 사이만 가져오기


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
