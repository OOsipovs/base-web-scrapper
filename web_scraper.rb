require 'open-uri'
require 'nokogiri'
require 'csv'
require 'json'

def scrapping
    html = URI.open("https://github.com/search?q=ruby+web+scraping")
    doc = Nokogiri::HTML(html)
    items_array = []

    doc.search(".repo-list li").each do |element|
        name = element.css('a.v-align-middle').text
        description = element.css('p.mb-1').text.strip

        items_array << [name, description]
    end

    #export_to_csv(items_array)
    
    #items_array.each_with_index do |item, index|
    #    puts "--------------"
    #    puts "#{index+1} - #{item[0]}"
    #    puts "#{item[1]}"
    #end

    export_to_json(items_array)
end

def export_to_csv(items_array)
    file_path = "data.csv"
    CSV.open(file_path,'w') do |csv|
        csv << ['#', 'Name', 'Description']
        items_array.each_with_index do |item, index|
            csv << [index+1, item[0], item[1]]
        end
    end
end

def export_to_json(items_array)
    file_path = "data.json"
    File.open(file_path, 'w') do |f|
        f.write(JSON.pretty_generate(items_array))
    end
end

scrapping

