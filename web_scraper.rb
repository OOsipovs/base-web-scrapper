require 'open-uri'
require 'nokogiri'
require 'csv'

def scrapping
    html = URI.open("https://github.com/search?q=ruby+web+scraping")
    doc = Nokogiri::HTML(html)
    items_array = []

    doc.search(".repo-list li").each do |element|
        name = element.css('a.v-align-middle').text
        description = element.css('p.mb-1').text.strip

        items_array << [name, description]
    end

    export(items_array)
    #items_array.each_with_index do |item, index|
    #    puts "--------------"
    #    puts "#{index+1} - #{item[0]}"
    #    puts "#{item[1]}"
    #end

end

def export(items_array)
    file_path = "data.csv"
    CSV.open(file_path,'w') do |csv|
        csv << ['#', 'Name', 'Description']
        items_array.each_with_index do |item|
            csv << [index+1, item[0], item[1]]
        end
    end
end

scrapping

