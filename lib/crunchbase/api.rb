# -*- coding: utf-8 -*-
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
    SUPPORTED_ENTITIES = ['person', 'company', 'financial-organization', 'product', 'service-provider']
    @timeout_limit = 60
    @redirect_limit = 2
    
    class << self; attr_accessor :timeout_limit, :redirect_limit end
    
    def self.single_entity(permalink, entity_name)
      raise CrunchException, "Unsupported Entity Type" unless SUPPORTED_ENTITIES.include?(entity_name)
      fetch(permalink, entity_name)
    end
    
    private
    
    # Returns the JSON parser, whether that's an instance of Yajl or JSON
    def self.parser
      if defined?(Yajl)
        Yajl::Parser
      else
        JSON
      end
    end

    # Fetches URI for the permalink interface.
    def self.fetch(permalink, object_name)
      uri = CB_URL + "#{object_name}/#{permalink}.js"
      get_json_response(uri)
    end
    
    # Fetches URI for the search interface.
    def self.search(query, page=1)
      require "cgi"
      uri = CB_URL + "search.js?query=#{CGI.escape(query)}&page=#{page}"
      get_json_response(uri)
    end

    # Searches for a permalink in a particular category.
    def self.permalink(parameters, category)
      require "cgi"
      qs = parameters.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v)}"}.join('&')
      uri = CB_URL + "#{category}/permalink?#{qs}"
      get_json_response(uri)
    end
    
    # Gets specified URI, then parses the returned JSON. Raises Timeout error 
    # if request time exceeds set limit. Raises CrunchException if returned
    # JSON contains an error.
    def self.get_json_response(uri)
      resp = Timeout::timeout(@timeout_limit) {
        get_url_following_redirects(uri, @redirect_limit)
      }
      j = parser.parse(resp)
      raise CrunchException, j["error"] if j["error"]
      j
    end

    # Performs actual HTTP requests, recursively if a redirect response is
    # encountered. Will raise HTTP error if response is not 200, 404, or 3xx.
    def self.get_url_following_redirects(uri_str, limit = 10)
      raise CrunchException, 'HTTP redirect too deep' if limit == 0

      url = URI.parse(uri_str)
      response = Net::HTTP.start(url.host, url.port) { |http| http.get(url.request_uri) }
      case response
        when Net::HTTPSuccess, Net::HTTPNotFound
          response.body
        when Net::HTTPRedirection
          get_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
      end
    end

  end
end
