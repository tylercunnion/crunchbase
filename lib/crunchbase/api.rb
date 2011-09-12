require 'net/http'
require 'json'
require 'timeout'

module Crunchbase
  class API
    CB_URL = 'http://api.crunchbase.com/v/1/'
    
    def self.person(permalink)
      fetch_uri = URI.parse(CB_URL + "person/" + permalink + ".js")
      fetch(fetch_uri)
    end
    
    # Fetches URI and parses JSON. Raises Timeout::Error if fetching times out.
    # Raises CrunchException if the returned JSON indicates an error.
    def self.fetch(uri)
      resp = Timeout::timeout(5) {
        Net::HTTP.get(uri)
      }
      j = JSON.parse(resp)
      raise CrunchException, j["error"] if j["error"]
      return j
    end
    
    
  end
end
  