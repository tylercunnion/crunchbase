$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require 'rspec'
require 'crunchbase'
require 'date'
require 'yaml'

key_yaml = YAML.load_file(File.join(File.dirname(__FILE__),'apikey.yml'))

Crunchbase::API.key = key_yaml["key"]
