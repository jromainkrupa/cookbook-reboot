require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run


# New features TODO today

# 1. Import from the web
  # nouvelle route
  # nouvelle action du controller
  # scrraper un truc

# 2. Recipe prep time
# 3. Mark recipe as done
# 4. Rating