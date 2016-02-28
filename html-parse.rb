require 'open-uri'
require 'nokogiri'

puts "Input search phrase: "
input = gets.chomp
searchTerm = input.split

holdingURL = "https://www.google.co.uk/search?q="

(0..(searchTerm.length-1)).each {|i|
  holdingURL += searchTerm[i]
  if i<searchTerm.length-1
    holdingURL += "%20"
  end
}

puts holdingURL



baseURL = holdingURL

doc = Nokogiri::HTML(open(baseURL))
puts ""
puts "SEARCH PAGE: " + baseURL

serps = doc.css('h3.r a:not([class!=""])')
# serpsSuppress = doc.css('h3.r a[class="sla"]')
# serps = serps-serpsSuppress
url=doc.css('cite')

puts ""
puts "Search term: "
puts ""
puts "# search results: " + serps.length.to_s
puts ""
puts "*************"

jump=0

for i in (0..serps.length-1)
  if serps[i].text.include? "Images"
    jump +=1
  else
    puts "Rank " + (i+1-jump).to_s + " Listing: " + serps[i].text
    puts "Rank " + (i+1-jump).to_s + " URL: " + url[i-jump].text
    puts "__________"
    puts ""
  end
end







