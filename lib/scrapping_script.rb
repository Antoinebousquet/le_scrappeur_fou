require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   

puts page.css('title')
# a = [
#   { "BTC" => 5245.12 },
#   { "ETH" => 217.34 }, 
#   etc
# ]

# crypto_scrapper

