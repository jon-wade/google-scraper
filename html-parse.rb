require 'open-uri'
require 'nokogiri'
require 'date'

puts 'Input search phrase: '
input = gets.chomp
search_term = input.split #split input at each space delimiter into an array

holding_url = 'https://www.google.co.uk/search?q=' #standard search query

#the following code constructs the search query by appending the search
#words onto the end of the holding URL and adding the encoding for a space
#which is %20 to separate each search word in the URL

(0..(search_term.length-1)).each {|i|
  holding_url += search_term[i]
  if i<search_term.length-1
    holding_url += '%20'
  end
}

base_url = holding_url

#use the Nokogiri library to parse the HTML page at the base_url location
#and output the search page to the console
doc = Nokogiri::HTML(open(base_url))


puts ''
puts 'SEARCH PAGE: ' + base_url

#search through the HTML page and locate all the tags that contain the
#search links using the css selector below
serps = doc.css('h3.r a:not([class!=""])')

# puts serps #outputing for debugging

def extracthref(serps)
  split_array=[]
  #go through the serps NodeList one by one and extract the href attribute of the anchor tags
  (0..serps.length-1).each {|i|
    serps_url = serps[i]['href']
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
  split_array
end

#sort out the problem when Image results appear and create a gap in the url_array

def array_na(array)
  #iterate through each element and check to see if its nil
  (0..array.length-1).each do |k|
    if array[k][0].nil?
      #if it is nil, insert the string N/A into that point in the array
      array[k][0] = 'N/A'
    end
  end
  array
end

#a user input method
def user_input
  input = gets.chomp
  input
end

#What does this do? Reading from the inside out, first the serps NodeList is passed into the extracthref
#method which pulls the href substring out and returns it into an array called split_array.
#split_array is a 2d array but with only one element in the second dimension as the other elements have been
#deleted. Then split_array is passed into the method array_na which substitutes any missing elements
#with the string N/A. This returns an array called array which is then flattened into a 1d array. Phew!!

url_array = array_na(extracthref(serps)).flatten


#format output header to the console
puts ''
puts 'Date: ' + Time.now.strftime("%Y/%m/%d")
puts ''
puts 'Search term: ' + input
puts ''
puts '# search results: ' + serps.length.to_s
puts ''
puts '# url results: ' + url_array.length.to_s
puts ''
puts '*************'


(0..serps.length-1).each do |i|
  #return the link titles from the listing on the page
  puts 'Rank ' + (i+1).to_s + ' Listing: ' + serps[i].text
  #return the link href from the listing on the page
  puts 'Rank ' + (i+1).to_s + ' URL: ' + url_array[i].to_s
  puts '__________'
  puts ''
end

#check to see whether the results should be inserted into the database
def insert_db
  puts 'Do you want to save the results in the database (Y/N): '
  answer = user_input
  if answer.upcase == 'Y'
    puts '*************'
    puts 'You answered yes'
    puts '*************'
    #insert database insertion method here
  elsif answer.upcase == 'N'
    puts '*************'
    puts 'Ok boss. Results not saved.'
    puts '*************'
  else
    puts '*************'
    puts 'I don\'t understand what you said, please can you re-enter your choice?'
    puts '*************'
    insert_db
  end
end

insert_db









