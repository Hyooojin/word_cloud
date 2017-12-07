require 'twkorean'

def twitterKorean
    # text = "한국어를 처리하는 예시입니닼ㅋㅋㅋㅋㅋ #한국어"
    # text = "모바일은 소비자가 있는 모든 분야에서 기본 조건이 됐다. 뉴스도, 쇼핑도, 금융도 모바일 안에서의 생존과 성공을 궁리한다."
    text = "레전드 of legend 우후훟 훓뚫룷뚫 들들볶다 을를 그를 따라 띵작 명작"
    twkorean = Twkorean::TwitterKoreanText.new
    text = twkorean.normalize(text)
    tokens = twkorean.tokenize(text)

    p "#Tokenize"
    p twkorean.tokens_to_string_list(tokens)
    p twkorean.tokens_to_token_list(tokens)
    
    p "Phrase extraction"
    p twkorean.extract_phrases(tokens)
  
end

twitterKorean