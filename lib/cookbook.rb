require "csv"
require_relative "recipe"
class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    save_csv
  end

  def find(index)
    @recipes[index]
  end

  def delete(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  private
  
  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      name = row[:name]
      description = row[:description]
      prep_time  = row[:prep_time]
      done  = row[:done] == "true"
      @recipes << Recipe.new(name: name,description: description, prep_time: prep_time, done: done)
    end
  end
  
  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["name", "description","prep_time","done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done?]
      end
    end
  end
end