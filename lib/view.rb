class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}" 
    end
  end

  def ask_for(stuff)
    puts "what's the #{stuff}"
    print ">"
    return gets.chomp
  end
end