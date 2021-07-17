require "nokogiri"
require "open-uri"
require_relative "recipe"

ingredient = "chocolate"
url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"

html = open(url).read

doc = Nokogiri::HTML(html,nil,'utf-8')

recipes = []
doc.search('.card__recipe').first(5).each do |element|
  name = element.search('.card__title').text.strip
  description = element.search('.card__summary').text.strip
  recipes << Recipe.new(name, description)
end