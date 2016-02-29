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

def extractHref(serps)
  split_array=[]
  #go through the serps NodeList one by one and extract the href attribute of the anchor tags
  (0..serps.length-1).each {|i|
    serps_url = serps[i]["href"]
    #remove junk that Google appends before and after the end of the returned search result pages
    #using a funky regular expression and push it into a new array
    split_array.push(serps_url.split(/(http.*?)(?=&)/))
  }
  #delete the junk in the array before the element we need
  (0..serps.length-1).each {|i|
    split_array[i].delete_at(0)
  }
  #delete the junk in the array after the element we need (note all elements have moved index by one)
  #due to the last function
  (0..serps.length-1).each {|i|
    split_array[i].delete_at(1)
  }
  return split_array
end

url_array = extractHref(serps)

# (0..url_array.length-1).each do |i|
#   puts url_array[i]
# end


#format output header to the console
puts ""
puts "Search term: "
puts ""
puts "# search results: " + serps.length.to_s
puts ""
puts "# url results: " + url_array.length.to_s
puts ""
puts "*************"

for i in (0..serps.length-1)
  #return the link titles from the listing on the page
  puts "Rank " + (i+1).to_s + " Listing: " + serps[i].text
  #return the link href from the listing on the page
  puts "Rank " + (i+1).to_s + " URL: " + url_array[i][0].to_s
  puts "__________"
  puts ""
end







