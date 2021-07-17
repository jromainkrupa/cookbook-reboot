require_relative "recipe"
require "nokogiri"
require "open-uri"

class RecipeScrapperService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"

    html = open(url).read
    doc = Nokogiri::HTML(html,nil,'utf-8')

    recipes = []
    doc.search('.card__recipe').first(5).each do |element|
      name = element.search('.card__title').text.strip
      description = element.search('.card__summary').text.strip
      
      link = element.css('.card__titleLink')[0]["href"]

      html_content_prep = URI.open(link.to_s).read
      doc_prep = Nokogiri::HTML(html_content_prep)
      prep_time = doc_prep.search('.recipe-meta-item-body').first.text.strip
      recipes << Recipe.new(name: name, description: description, prep_time: prep_time)
    end
    recipes
  end
end