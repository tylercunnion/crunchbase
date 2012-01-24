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
      uri = CB_URL + "#{object_name}/#{permalink}.js"

      resp = Timeout::timeout(5) {
        fetch_but_follow_redirects(uri, 5)
      }

      j = parser.parse(resp.body)
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

    def self.fetch_but_follow_redirects(uri_str, limit = 10)
      # You should choose better exception.
      raise ArgumentError, 'HTTP redirect too deep' if limit == 0

      url = URI.parse(uri_str)
      req = Net::HTTP::Get.new(url.path, { 'User-Agent' => 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5' })
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then fetch_but_follow_redirects(response['location'], limit - 1)
      else
        response.error!
      end
    end

  end
end








