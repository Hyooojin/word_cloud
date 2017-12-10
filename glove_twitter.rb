require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'
require 'glove'
require 'httparty'

  url = "http://m.blog.naver.com/dlwndud1974/221158801277"
  # response = HTTParty.get(url)
  # doc = Nokogiri::HTML(response.body)
  doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
  # doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'euc-kr')
  doc.css('script').remove
  doc.xpath("//@*[starts-with(name(),'on')]").remove


  title = doc.css('title').text
  body = doc.css('body').text

  # all_text=Array.new
  all_text = ""
  body.split("\n").each do |line|
    l = line.strip
    # l.gsub!(/<\/?[^>]*>/, "")
    if(l.length > 0)
      # puts l
      all_text += l
      # all_text << l
    end
  end
  # puts all_text

  # puts all_text.class
  # puts "========================"
  model = Glove::Model.new
  model.fit(all_text)
  corpus = Glove::Corpus.build(all_text)
  model.fit(corpus)

  # Finally, to query the model, we need to train it
  model.train

  puts "======================"
  puts model.most_similar("여행")




  processor = TwitterKorean::Processor.new
  # Noralize
  # twitter = processor.normalize(all_text)
  # Tokenize
  # twitter = processor.tokenize(all_text)
  # Stemming
  twitter = processor.stem(all_text)

  # puts twitter
  # puts twitter.class
  # document = TfIdfSimilarity::Document.new(twitter)
  # puts document
  # model = TfIdfSimilarity::TfIdfModel.new(document)
  # matrix = model.similarity_matrix
  # extract pharases
  # twitter = processor.extract_phrases(all_text)
  # twitter = processor.extract_phrases(all_text).first.metadata


  # words_count
  word = Hash.new(0)
  twitter.each do |t|
    if word.has_key? t
      word[t] += 1 if t.metadata.pos == :noun
    else
      word.store(t, 1) if t.metadata.pos == :noun
    end
  end
  word = word.sort_by {|k, v| v}.reverse.to_h
  # puts "====="
  # puts word
