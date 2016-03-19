# google-scraper
Experimenting with using Ruby to scrape Google search results and store in SQLite3

The two main files in here are autoscrape.rb and html-parse.rb. autoscrape.rb is just an automatic version that runs as a
cronjob every day. html-parse.rb allows the input of a search term to the program, which will then go to google.co.uk and scrape down the top 10 search results for that search term, noting the date, rank and click-through destination of the term.

I use autoscape.rb to store the search results for my own name into a SQLite3 database which I use to analyse how well my
sites and mentions are ranking against terms people may be using to search for me.

It runs off my laptop every morning and I periodically analyse the terms.

Looking to extend by being able to plot rank over time for various online properties as well as create a web interface for
inputing and retrieving results.
