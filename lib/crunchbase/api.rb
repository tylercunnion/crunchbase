require 'net/http'

begin
  require 'yajl'
rescue LoadError
  require 'json'
end

require 'timeout'

module Crunchbase
  
  # Handles the actual calls to the Crunchbase API through a series of class
  # methods, each referring to a CB entity type. Each method returns the raw
  # JSON returned from the API. You should probably be using the factory
  # methods provided on each entity class instead of calling these directly.
  class API
    CB_URL = 'http://api.crunchbase.com/v/1/'
    
    def self.person(permalink)
      fetch(permalink, 'person')
    end
    
    def self.company(permalink)
      fetch(permalink, 'company')
    end
    
    def self.financial_organization(permalink)
      fetch(permalink, 'financial-organization')
    end
    
    def self.product(permalink)
      fetch(permalink, 'product')
    end
    
    def self.service_provider(permalink)
      fetch(permalink, 'service-provider')
    end
    
    private
    
    # Fetches URI and parses JSON. Raises Timeout::Error if fetching times out.
    # Raises CrunchException if the returned JSON indicates an error.
    def self.fetch(permalink, object_name)
      uri = URI.parse(CB_URL + "#{object_name}/#{permalink}.js")
      resp = Timeout::timeout(5) {
        Net::HTTP.get(uri)
      }
      j = parser.parse(resp)
      raise CrunchException, j["error"] if j["error"]
      return j
    end
    
    def self.parser
      if defined?(Yajl)
        Yajl::Parser
      else
        JSON
      end
    end
    
    
  end
end
  