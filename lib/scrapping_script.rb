require 'nokogiri'
require 'open-uri'

def open_html
  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
end

def create_names_array (page)
  all_crypto_names = page.xpath('//td[@class="text-left col-symbol"]')
  all_crypto_names_array = []
  all_crypto_names.each do |crypto_name|
  	all_crypto_names_array << crypto_name.text
  end
  all_crypto_names_array
end

def create_prices_array (page)
  all_crypto_prices = page.xpath('//a[@class="price"]')
  all_crypto_prices_array = []
  all_crypto_prices.each do |crypto_price|
  	all_crypto_prices_array << crypto_price.text
  end
	all_crypto_prices_array
end

def remove_usd_symbol(prices_array)
    prices_array.each do |arr|
    	arr.slice!(0)
  end
  prices_array
end

def create_array_of_hashes (all_crypto_names_array, all_crypto_prices_array)
  all_crypto_names_array.zip(all_crypto_prices_array).map { |k, v| { k => v.to_f } }
end

def perform
  all_crypto = create_array_of_hashes(create_names_array(open_html), remove_usd_symbol(create_prices_array(open_html)))
  # print all_crypto
end

# perform
