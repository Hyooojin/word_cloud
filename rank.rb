require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'


  url = "https://m.blog.naver.com/jjjadeland/221147158314"
  doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
  # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')
  doc.css('script').remove
  doc.xpath("//@*[starts-with(name(),'on')]").remove


  title = doc.css('title').text
  body = doc.css('body').text

  all_text=Array.new
  # all_text = ""
  body.split("\n").each do |line|
    l = line.strip
    # l.gsub!(/<\/?[^>]*>/, "")
    if(l.length > 0)
      # puts l
      # all_text += l

      all_text <<  TfIdfSimilarity::Document.new(l)
    end
  end
  puts "========="
  puts title
all_text << TfIdfSimilarity::Document.new(title)
  # puts all_text.class
  # puts all_text

  # puts all_text.class
  # puts "========================"

  # processor = TwitterKorean::Processor.new
  # # Noralize
  # # twitter = processor.normalize(all_text)
  # # Tokenize
  # # twitter = processor.tokenize(all_text)
  # # Stemming
  # twitter = processor.stem(all_text)

  # puts twitter
  # puts twitter.class
  # document = TfIdfSimilarity::Document.new(all_text)
  # puts "document"
  # puts document
  model = TfIdfSimilarity::TfIdfModel.new(all_text)
  matrix = model.similarity_matrix
  # puts model
  # puts matrix
  # matrix[model.document_index(document1), model.document_index(document2)]
  # puts all_text[7]
  tfidf_by_term = {}
  all_text[-1].terms.each do |term|
    tfidf_by_term[term] = model.tfidf(all_text[-1], term)
  end
  puts tfidf_by_term.sort_by{|_,tfidf| -tfidf}


  # extract pharases
  # twitter = processor.extract_phrases(all_text)
  # twitter = processor.extract_phrases(all_text).first.metadata


  # words_count
  # word = Hash.new(0)
  # twitter.each do |t|
  #   if word.has_key? t
  #     word[t] += 1 if t.metadata.pos == :noun
  #   else
  #     word.store(t, 1) if t.metadata.pos == :noun
  #   end
  # end
  # word = word.sort_by {|k, v| v}.reverse.to_h
  # puts "====="
  # puts word
