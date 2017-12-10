require 'open-uri'
require 'nokogiri'
require 'open_uri_redirections'
require 'twkorean'
require 'twitter-korean-text-ruby'
require 'matrix'
require 'tf-idf-similarity'
require 'unicode_utils'

document1 = TfIdfSimilarity::Document.new("Lorem")
document2 = TfIdfSimilarity::Document.new("Pellentesque")
document3 = TfIdfSimilarity::Document.new("Nam")
corpus = [document1, document2, document3]
puts corpus
model = TfIdfSimilarity::TfIdfModel.new(corpus)
matrix = model.similarity_matrix
# matrix[model.document_index(document1), model.document_index(document2)]
tfidf_by_term = {}
document1.terms.each do |term|
  tfidf_by_term[term] = model.tfidf(document1, term)
end
puts tfidf_by_term.sort_by{|_,tfidf| -tfidf}


text = "Lorem ipsum dolor sit amet..."
tokens = UnicodeUtils.each_word(text).to_a - ['and', 'the', 'to']
term_counts = Hash.new(0)
size = 0
tokens.each do |token|
  # Unless the token is numeric.
  unless token[/\A\d+\z/]
    # Remove all punctuation from tokens.
    term_counts[token.gsub(/\p{Punct}/, '')] += 1
    size += 1
  end
end
document1 = TfIdfSimilarity::Document.new(text, :term_counts => term_counts, :size => size)
