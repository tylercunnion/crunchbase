#! /usr/bin/env ruby
$: << '../lib'
require 'crunchbase'
require 'yaml'
Crunchbase::API.key = YAML.load_file('apikey.yml')['key']
