# Load the Rails application.
require_relative "application"

app_environment_variables = File.join(Rails.root, '.env')
load(app_environment_variables) if File.exist?(app_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!
