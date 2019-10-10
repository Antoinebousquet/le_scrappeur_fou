require 'nokogiri'
require 'open-uri'
require 'pry'

# Le site du Val d'oise
def val_doise_website
  page = Nokogiri::HTML(open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  return page
end

# récupération et affichage de tous les noms de ville
def get_all_town_names (page_2)
  all_name = page_2.xpath('//a[@class="lientxt"]')
  all_name_array = Array.new
  all_name.each do |nam|
    all_name_array << nam.text
  end
  return all_name_array
end

# Récupérer et transformer les url des sites de toutes les villes
def all_townhall_urls (page_2)
  all_url = page_2.xpath('//a[@class="lientxt"]/@href')
  all_url_array = Array.new
  all_url.each do |url_town|
    all_url_array << ('https://www.annuaire-des-mairies.com/' + url_town.text)
  end
  return all_url_array
end

# Accéder au mail d'une ville
def townhall_url (url)
  all_mails_array = Array.new
  url.each do |u|
    page_3 = Nokogiri::HTML(open(u.to_s))
    mail = page_3.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    all_mails_array << mail.text
  end
  return all_mails_array
end

# tableau final
def create_array_of_hashes (town_names, emails)
  final = town_names.zip(emails).map { |k, v| { k => v } }
  puts final
end

create_array_of_hashes(get_all_town_names(val_doise_website), townhall_url(all_townhall_urls(val_doise_website)))