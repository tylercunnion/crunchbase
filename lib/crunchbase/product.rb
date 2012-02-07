require 'date'
module Crunchbase
  class Product < CB_Object
    
    include Crunchbase::DateMethods
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url, :blog_url,
      :blog_feed_url, :twitter_username, :stage_code, :deadpooled_url,
      :invite_share_url, :created_at, :updated_at, :overview, :image, 
      :company_permalink, :company_name, :milestones, :video_embeds, 
      :external_links
      
    def self.get(permalink)
      j = API.product(permalink)
      return Product.new(j)
    end

    def self.find(name)
      get(API.permalink({name: name}, "products")["permalink"])
    end
    
    def initialize(json)
      @name = json['name']
      @permalink = json['permalink']
      @crunchbase_url = json['crunchbase_url']
      @homepage_url = json['homepage_url']
      @blog_url = json['blog_url']
      @blog_feed_url = json['blog_feed_url']
      @twitter_username = json['twitter_username']
      @stage_code = json['stage_code']
      @deadpooled_url = json['deadpooled_url']
      @invite_share_url = json['invite_share_url']
      @tag_list = json['tag_list']
      @alias_list = json['alias_list']
      @deadpooled_year = json['deadpooled_year']
      @deadpooled_month = json['deadpooled_month']
      @deadpooled_day = json['deadpooled_day']
      @launched_year = json['launched_year']
      @launched_month = json['launched_month']
      @launched_day = json['launched_day']
      @created_at = DateTime.parse(json['created_at'])
      @updated_at = DateTime.parse(json['updated_at'])
      @overview = json['overview']
      @image = json['image']
      @company_permalink = json['company']['permalink']
      @company_name = json['company']['name']
      @milestones = json['milestones']
      @video_embeds = json['video_embeds']
      @external_links = json['external_links']
    end
      
    # Returns the date the product was deadpooled, or nil if not provided.
    def deadpooled
      @deadpooled ||= date_from_components(@deadpooled_year, @deadpooled_month, @deadpooled_day)
    end    
    
    # Returns the date the product was launched, or nil if not provided.
    def launched
      @launched ||= date_from_components(@launched_year, @launched_month, @launched_day)
    end
    
    # Lazy-loads the associated Company entity and caches it. Pass true to
    # force reload.
    def company(force_reload = false)
      return @company unless @company.nil? or force_reload
      @company = Company.get(@company_permalink)
      return @company
    end
  end
end
