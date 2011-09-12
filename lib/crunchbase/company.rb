require 'date'
module Crunchbase
  class Company < CB_Object
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url, :blog_url,
      :blog_feed_url, :twitter_username, :category_code, :number_of_employees,
      :founded_year, :founded_month, :founded_day, :deadpooled_year,
      :deadpooled_month, :deadpooled_day, :deadpooled_url, :tag_list, 
      :alias_list, :email_address, :phone_number, :description, :created_at,
      :updated_at, :overview, :image, :products, :relationships, :competitions,
      :providerships, :total_money_raised, :funding_rounds, :investments,
      :acquisition, :acquisitions, :offices, :milestones, :ipo, :video_embeds,
      :screenshots, :external_links
      
    def self.get(permalink)
      j = API.company(permalink)
      c = Company.new(j)
      return c
    end
    
    def initialize(json)
      @name = json["name"]
      @permalink = json["permalink"]
      @crunchbase_url = json["crunchbase_url"]
      @homepage_url = json["homepage_url"]
      @blog_url = json["blog_url"]
      @blog_feed_url = json["blog_feed_url"]
      @twitter_username = json["twitter_username"]
      @category_code = json["category_code"]
      @number_of_employees = json["number_of_employees"]
      @founded_year = json["founded_year"]
      @founded_month = json["founded_month"]
      @founded_day = json["founded_day"]
      @deadpooled_year = json["deadpooled_year"]
      @deadpooled_month = json["deadpooled_month"]
      @deadpooled_day = json["deadpooled_day"]
      @deadpooled_url = json["deadpooled_url"]
      @tag_list = json["tag_list"]
      @alias_list = json["alias_list"]
      @email_address = json["email_address"]
      @phone_number = json["phone_number"]
      @description = json["description"]
      @created_at = DateTime.parse(json["created_at"])
      @updated_at = DateTime.parse(json["updated_at"])
      @overview = json["overview"]
      @image = json["image"]
      @products = json["products"]
      @relationships = json["relationships"]
      @competitions = json["competitions"]
      @providerships = json["providerships"]
      @total_money_raised = json["total_money_raised"]
      @funding_rounds = json["funding_rounds"]
      @investments = json["investments"]
      @acquisition = json["acquisition"]
      @acquisitions = json["acquisitions"]
      @offices = json["offices"]
      @milestones = json["milestones"]
      @ipo = json["ipo"]
      @video_embeds = json["video_embeds"]
      @screenshots = json["screenshots"]
      @external_links = json["external_links"]
    end
    
    def founded
      begin
        founded = Date.new(@founded_year, @founded_month, @founded_day)
      rescue
        founded = nil
      end
      return founded      
    end
    
    def deadpooled
      begin
        dp = Date.new(@deadpooled_year, @deadpooled_month, @deadpooled_day)
      rescue
        dp = nil
      end
      return dp
    end
        
  end
end
