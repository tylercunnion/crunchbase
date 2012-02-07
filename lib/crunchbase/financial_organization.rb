require 'date'
module Crunchbase
  class FinancialOrganization < CB_Object
    
    include Crunchbase::DateMethods
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url, :blog_url,
      :blog_feed_url, :twitter_username, :phone_number, :description,
      :email_address, :number_of_employees, :created_at, :updated_at, 
      :overview, :image, :offices, :relationships, :investments, :milestones, 
      :providerships, :funds, :video_embeds, :external_links
    
    # Factory method to return a FinancialOrganization instance from a permalink
    def self.get(permalink)
      j = API.financial_organization(permalink)
      f = FinancialOrganization.new(j)
      return f
    end

    def self.find(name)
      get(API.permalink({name: name}, "financial-organizations")["permalink"])
    end
    
    def initialize(json)
      @name = json['name']
      @permalink = json['permalink']
      @crunchbase_url = json['crunchbase_url']
      @homepage_url = json['homepage_url']
      @blog_url = json['blog_url']
      @blog_feed_url = json['blog_feed_url']
      @twitter_username = json['twitter_username']
      @phone_number = json['phone_number']
      @description = json['description']
      @email_address = json['email_address']
      @number_of_employees = json['number_of_employees']
      @founded_year = json['founded_year']
      @founded_month = json['founded_month']
      @founded_day = json['founded_day']
      @tag_list = json['tag_list']
      @alias_list = json['alias_list']
      @created_at = DateTime.parse(json["created_at"])
      @updated_at = DateTime.parse(json["updated_at"])
      @overview = json['overview']
      @image = json['image']
      @offices = json['offices']
      @relationships = Relationship.array_from_relationship_list(json["relationships"]) if json["relationships"]
      @investments = Investment.array_from_investment_list(json['investments']) if json['investments']
      @milestones = json['milestones']
      @providerships = Relationship.array_from_relationship_list(json['providerships']) if json["providerships"]
      @funds = json['funds']
      @video_embeds = json['video_embeds']
      @external_links = json['external_links']
    end
    
    # Returns the date the financial org was founded, or nil if not provided.
    def founded
      @founded ||= date_from_components(@founded_year, @founded_month, @founded_day)    
    end
  end
end
