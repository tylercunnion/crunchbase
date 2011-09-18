require 'date'
module Crunchbase
  class Person < CB_Object
            
    attr_reader :first_name, :last_name, :permalink, :crunchbase_url,
      :homepage_url, :birthplace, :twitter_username, :blog_url, :blog_feed_url,
      :affiliation_name, :born_year, :born_month, :born_day, :created_at,
      :updated_at, :overview, :tag_list, :alias_list, :created_at, :updated_at,
      :overview, :relationships, :investments, :milestones, :video_embeds,
      :external_links, :web_presences
    
    def self.get(permalink)
      j = API.person(permalink)
      p = Person.new(j)
      return p
    end
    
    def initialize(json)
      @first_name = json["first_name"]
      @last_name = json["last_name"]
      @permalink = json["permalink"]
      @crunchbase_url = json["crunchbase_url"]
      @homepage_url = json["homepage_url"]
      @birthplace = json["birthplace"]
      @twitter_username = json["twitter_username"]
      @blog_url = json["blog_url"]
      @blog_feed_url = json["blog_feed_url"]
      @affiliation_name = json["affiliation_name"]
      @born_year = json["born_year"]
      @born_month = json["born_month"]
      @born_day = json["born_day"]
      @tag_list = json["tag_list"]
      @alias_list = json["alias_list"]
      @created_at = DateTime.parse(json["created_at"])
      @updated_at = DateTime.parse(json["updated_at"])
      @overview = json["overview"]
      
      @relationships = Relationship.array_from_relationship_list(json["relationships"]) if json["relationships"]
      @investments = Investment.array_from_investment_list(json["investments"]) if json["investments"]
      @milestones = json["milestones"]
      @video_embeds = json["video_embeds"]
      @external_links = json["external_links"]
      @web_presences = json["web_presences"]
    end
    
    # Returns a date object, or nil if Date cannot be created from
    # provided information.
    def born
      begin
        born = Date.new(@born_year, @born_month, @born_day)
      rescue
        born = nil
      end
      born
    end
    
  end
end