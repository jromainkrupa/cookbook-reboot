require_relative "cookbook"
require_relative "view"
require_relative "recipe"

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
    # créer une nouvelle recette
    recipe = Recipe.new(name, description)
    # ajouter la recette dans le cookbook
    @cookbook.add(recipe)
  end
end