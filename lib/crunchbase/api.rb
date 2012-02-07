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
    @timeout_limit = 60
    @redirect_limit = 1
    
    class << self; attr_accessor :timeout_limit, :redirect_limit end

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
      resp = Timeout::timeout(@timeout_limit) {
        get_url_following_redirects(uri, @redirect_limit)
      }
      j = parser.parse(resp)
      raise CrunchException, j["error"] if j["error"]
      return j
    end

    # Searches for a permalink in a particular category, and parses the returned
    # JSON.
    def self.permalink(parameters, category)
      require "cgi"
      qs = parameters.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v)}"}.join('&')
      uri = CB_URL + "#{category}/permalink?#{qs}"
      resp = Timeout::timeout(60) {
        Net::HTTP.get(URI.parse(uri))
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

    def self.get_url_following_redirects(uri_str, limit = 10)
      raise CrunchException, 'HTTP redirect too deep' if limit == 0

      url = URI.parse(uri_str)
      req = Net::HTTP::Get.new(url.path)
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      case response
        when Net::HTTPSuccess
          response.body
        when Net::HTTPRedirection
          get_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
      end
    end

  end
end
