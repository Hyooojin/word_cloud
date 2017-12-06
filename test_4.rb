require 'twitter-korean-text-ruby'

def testTk
    
    # text = "한국어를 처리하는 예시입니닼ㅋㅋㅋㅋㅋ #한국어"
    # text = "모바일은 소비자가 있는 모든 분야에서 기본 조건이 됐다. 뉴스도, 쇼핑도, 금융도 모바일 안에서의 생존과 성공을 궁리한다."
    text = "<h1>레전드 of legend 우후훟 훓뚫룷뚫 들들볶다 을를 그를 따라 띵작 명작</h1>"
    processor = TwitterKorean::Processor.new
    # OR with JVM arguments
    # processor = TwitterKorean::Processor.new('-Xms126M', '-Xmx512M', ...)
    
    # Normalize
    p processor.normalize(text)
    # => "형태소 분석을 합니다ㅋㅋㅋㅋㅋㅋ"
    
    # Tokenize
    p processor.tokenize(text)
    # => ["한국어", "를", " ", "처리", "하는", " ", "예시", "입니", "다", " ", "ㅋㅋ"]
    
    # Stemming
    p processor.stem(text)
    # => ["한국어", "를", " ", "처리", "하다", " ", "예시", "이다", " ", "ㅋㅋ"]
    
    # extract phrases
    p processor.extract_phrases(text)
    # => ["한국어", "처리", "처리하는 예시", "예시"]
    p processor.extract_phrases(text).first.metadata
    # => 첫번째 단어에 대한 메타 데이터  noun, 0, 3 각 index 별로 metadata를 확인 가능함.
end

testTk