require 'open-uri'
require 'nokogiri'

def scrapping
    url = "https://github.com/search?q=ruby+web+scraping"
    items_array = []

    html = URI.open(url)
    doc = Nokogiri::HTML(html)

    total_result = doc.css('div.d-flex.flex-column.flex-md-row.flex-justify-between.border-bottom.pb-3.position-relative h3').text.split(" ")[0].to_i
    result_per_page = 10

    max_page = (total_result / result_per_page).floor + 1

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

def scrapping_method_2
    url="https://github.com/search?q=ruby+web+scraping"
    items_array = []
    page = 1
    next_page = true

    while next_page
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

        disabled_next_button = doc.search('span.next_page.disabled')
        if disabled_next_button.any?
            next_page = false
        else
            page += 1
        end

        sleep(10)
    end

    items_array.each_with_index do |item, index|
        puts "--------------"
        puts "#{index+1} - #{item[:name]}"
        puts "#{item[:description]}"
    end
end

#scrapping
scrapping_method_2

