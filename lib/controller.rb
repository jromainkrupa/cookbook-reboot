require_relative "cookbook"
require_relative "view"
require_relative "recipe"
require_relative "recipe_scrapper_service"
require "amazing_print"

class Controller
  def initialize(cookbook)
    # TODO view / cookbook
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # aller chercher les recettes dans le cookbook
    recipes = @cookbook.all
    # afficher les recettes à l'utilisateurs
    @view.display(recipes)
  end

  def create
    # demander à l'utilisateur un nom et une description
    name = @view.ask_for("name")
    description = @view.ask_for("description")
    prep_time = @view.ask_for("prep time")
    # créer une nouvelle recette
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time)
    # ajouter la recette dans le cookbook
    @cookbook.add(recipe)
  end

  def destroy
    list
    # demander quelle recette le user souhaite détruire (index)
    index = @view.ask_for("index").to_i - 1
    @cookbook.delete(index)
  end

  def import
    # demande un mot clés à rechercher sur allrecipes.com
    ingredient = @view.ask_for("keyword")
    # on affiche les 5 recettes relatives à ce keyword
    recipes = RecipeScrapperService.new(ingredient).call
    # il selectionne une recette parmi les 5 avec l'index
    @view.display(recipes)
    index = @view.ask_for("index").to_i - 1
    recipe = recipes[index]
    # la recette s'ajoute dans le cookbook
    @cookbook.add(recipe)
  end

  def mark_as_done
    # lister les recettes
    list
    # quel recette souhaites tu marquer as done
    index = @view.ask_for("index").to_i - 1
    # marquer la recette as done
    # recipe = @cookbook.find(index)
    # recipe.mark_as_done!
    # @cookbook.save_csv

    @cookbook.mark_as_done(index)
  end
end