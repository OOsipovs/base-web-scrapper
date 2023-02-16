require 'open-uri'
require 'nokogiri'

def scrapping
    url = "https://github.com/search?q=ruby+web+scraping"
    items_array = []

    max_page = 3 
    for page in 1..max_page
        puts("Scrapping page #{page}...")

        html = URI.open(url+"&p=#{page}")
        doc = Nokogiri::HTML(html)
        items_array = []
    
        doc.search(".repo-list li").each do |element|
            name = element.css('a.v-align-middle').text
            description = element.css('p.mb-1').text.strip
            item = {
                name: name,
                description: description
            }
            items_array.push(item)
        end
        sleep(10)
    end

    items_array.each_with_index do |item, index|
        puts "--------------"
        puts "#{index+1} - #{item[:name]}"
        puts "#{item[:description]}"
    end
end

scrapping

