url = params[:src_url]
doc = Nokogiri::HTML(open(url, :allow_redirections => :safe), nil, 'utf-8')
title = doc.css('title').text
body = doc.css('body').text


all_text = ""
body.split("\n").each do |line|
  l = line.strip
  l.gsub!(/<\/?[^>]*>/, "")
  if(l.length > 0)
    # puts l
    all_text += l
  end
end

Post.create(
      title: title,
      src_url: params[:src_url],
      tag1: word.keys[0],
      tag2: word.keys[1],
      tag3: word.keys[2],
      desc: "TEST TEST TEST"
      )
    redirect_to root_path
  end
