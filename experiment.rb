require 'open-uri'
require 'nokogiri'

base_url = 'https://www.google.co.uk/search?q=weber%20shandwick'

doc = Nokogiri::HTML(open(base_url))

serps = doc.css('h3.r a:not([class!=""])')

puts serps


