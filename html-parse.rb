require 'open-uri'
require 'nokogiri'

puts "Input search phrase: "
input = gets.chomp
searchTerm = input.split #split input at each space delimiter into an array

holdingURL = "https://www.google.co.uk/search?q=" #standard search query

#the following code constructs the search query by appending the search
#words onto the end of the holding URL and adding the encoding for a space
#which is %20 to separate each search word in the URL

(0..(searchTerm.length-1)).each {|i|
  holdingURL += searchTerm[i]
  if i<searchTerm.length-1
    holdingURL += "%20"
  end
}

baseURL = holdingURL

#use the Nokogiri library to parse the HTML page at the baseURL location
#and output the search page to the console
doc = Nokogiri::HTML(open(baseURL))
puts ""
puts "SEARCH PAGE: " + baseURL

#search through the HTML page and locate all the tags that contain the
#search links using the css selector below
serps = doc.css('h3.r a:not([class!=""])')

puts serps #outputing for debugging


#go through the serps NodeList one by one and extract the href attribute of the anchor tags
#TO DO: this needs to be turned into a method
(0..serps.length-1).each {|i|
  serps_url = serps[i]["href"]
  #remove junk that Google appends before and after the end of the returned search result pages
  #using a funky regular expression
  split_array = serps_url.split(/(http.*?)(?=&)/)
  puts split_array[1]
}



#format output header to the console
puts ""
puts "Search term: "
puts ""
puts "# search results: " + serps.length.to_s
puts ""
puts "*************"

jump=0  #this is currently a hack to deal with image results appearing in search listings - needs fixing

for i in (0..serps.length-1)
  if serps[i].text.include? "Images" #same hack, dealing with pages that contain image result listings
    jump +=1
  else
    #return the link titles from the listing on the page
    puts "Rank " + (i+1-jump).to_s + " Listing: " + serps[i].text
    #return the link href from the listing on the page - needs fixing
    #puts "Rank " + (i+1-jump).to_s + " URL: " + url[i-jump].text
    puts "__________"
    puts ""
  end
end







