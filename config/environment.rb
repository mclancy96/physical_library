# Load the Rails application.
require_relative "application"
require 'yaml'
# Initialize the Rails application.




# Add this line before any YAML loading occurs
YAML::ENGINE.yamler = 'syck'

Rails.application.initialize!
