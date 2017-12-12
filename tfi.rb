require 'matrix'
require 'tf-idf-similarity'
require 'narray'

document1 = "Lorem ipsum dolor sit amet..."
document2 = "Pellentesque sed ipsum dui..."
document3 = "Nam scelerisque dui sed leo..."
corpus = [document1, document2, document3]
p corpus.class
p corpus[0]
co = Array.new
corpus.each do |c|
  puts c
  co << TfIdfSimilarity::Document.new(c)
  puts co
end
p "++++++++++++++++++++"
p co

model = TfIdfSimilarity::TfIdfModel.new(co, :library => :narray)
p "$$$$$$$$$$$$$$$$$$$$$$"
p model

matrix = model.similarity_matrix
p "%%%%%%%%%%%%%%%%%%%"
p matrix

# matrix[model.document_index(document1), model.document_index(document2)]

# p matrix[model.document_index(document1), model.document_index(document2)]

tfidf_by_term = {}
co[0].terms.each do |term|
  tfidf_by_term[term] = model.tfidf(co[0], term)
end
puts "===================================="
puts tfidf_by_term.sort_by{|_,tfidf| -tfidf}
