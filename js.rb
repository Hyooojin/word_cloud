
require 'open-uri'      # included with Ruby; only needed to load HTML from a URL
require 'nokogiri'      # gem install nokogiri   read more at http://nokogiri.org

url = "https://stackoverflow.com/questions/8291789/remove-all-javascript-from-an-html-page"
doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
doc.css('script').remove                             # Remove <script>…</script>
puts doc                                             # Source w/o script blocks

doc.xpath("//@*[starts-with(name(),'on')]").remove   # Remove on____ attributes
# puts doc                                             # Source w/o any JavaScript
