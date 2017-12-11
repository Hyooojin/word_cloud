url = "https://m.blog.naver.com/sera8668/221159434304"
# url = "http://navercast.naver.com/magazine_contents.nhn?rid=1639&contents_id=139016"
puts url.match(/[blog]naver/)

#1. /a/
# -> a
#2. /\?/
# -> The backslash means "don't treat the next character as special; treat it as itself."
# The special characters include ^, $, ? , ., /, \, [, ], {, }, (, ), +, and *.
#3. /.naver/ A dot matches any charactr with the exception of a newline.
# /navercast -> /naver
# .naver.com -> .naver
#4 /[dr]naver/ dnavr or rnaver
#5 
