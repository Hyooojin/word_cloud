text = "Pack my #box with #5 dozen liquor.#jugs link.com/liquor#jugs #2good #first#second"

puts text.match()
# 1
# /(?:^|\s)(?:(?:#\d+?)|(#\w+?))\s/i
# /(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i
# /(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/i
# #([A-Za-z0-9]+)

#2
puts text.scan(/ #[[:digit:]]?[[:alpha:]]+ /).map{ |s| s.strip[1..-1]}
