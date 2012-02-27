require 'date'
module Crunchbase
  class ServiceProvider < CB_Object
    
    ENT_NAME = "service-provider"
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url, 
    :phone_number, :created_at, :updated_at, :overview, :image, :offices,
    :providerships, :external_links

    def self.find(name)
      get(API.permalink({name: name}, "service-providers")["permalink"])
    end
    
    def initialize(json)
      @name = json["name"]
      @permalink = json["permalink"]
      @crunchbase_url = json["crunchbase_url"]
      @homepage_url = json["homepage_url"]
      @phone_number = json["phone_number"]
      @tag_list = json["tag_list"]
      @alias_list = json["alias_list"]
      @created_at = DateTime.parse(json["created_at"])
      @updated_at = DateTime.parse(json["updated_at"])
      @overview = json["overview"]
      @image = json["image"]
      @offices = json["offices"]
      @providerships = Relationship.array_from_relationship_list(json["providerships"]) if json["providerships"]
      @external_links = json["external_links"]
    end
    
    
  end
end
