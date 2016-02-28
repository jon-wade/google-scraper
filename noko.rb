require 'open-uri'
require 'nokogiri'

puts "Input search phrase: "
input = gets.chomp
searchTerm = input.split

baseURL = "https://www.google.co.uk/search?q="

(0..(searchTerm.length-1)).each {|i|
  baseURL += searchTerm[i]
  if i<searchTerm.length-1
    baseURL += "%20"
  end
}

puts baseURL

doc = Nokogiri::HTML(open(baseURL))

serps = doc.css('h3.r a')
serpsSuppress = doc.css('h3.r a[class="sla"]')

(0..serps.length-1).each do |i|
  puts "Link " + i.to_s + ": " + serps[i]
  (0..serpsSuppress.length-1).each do |j|
    if serps[i].to_s == serpsSuppress[j].to_s
      puts "match"
    end
  end
end

serps = serps-serpsSuppress
puts serps





