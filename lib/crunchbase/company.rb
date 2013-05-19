require 'date'
module Crunchbase
  # Represents a Company listed in the Crunchbase.
  class Company < CB_Object
    
    ENT_NAME = "company"
    ENT_PLURAL = "companies"
    
    include Crunchbase::DateMethods
    
    attr_reader :name, :permalink, :crunchbase_url, :homepage_url, :blog_url,
      :blog_feed_url, :twitter_username, :category_code, :number_of_employees,
      :deadpooled_url, :email_address, :phone_number, :description, 
      :created_at, :updated_at, :overview, :image, :competitions, 
      :total_money_raised, :funding_rounds, :acquisition, :acquisitions,
      :offices, :ipo, :video_embeds, :screenshots, :external_links,
      :deadpooled_year, :deadpooled_month, :deadpooled_day,
      :founded_year, :founded_month, :founded_day
    
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
      @image = Image.create(json["image"])
      @products_list = json["products"]
      @relationships_list = json["relationships"]
      @competitions = json["competitions"]
      @providerships_list = json["providerships"]
      @total_money_raised = json["total_money_raised"]
      @funding_rounds = json["funding_rounds"]
      @investments_list = json['investments']
      @acquisition = json["acquisition"]
      @acquisitions = json["acquisitions"]
      @offices = json["offices"]
      @milestones_list = json["milestones"]
      @ipo = json["ipo"]
      @video_embeds = json["video_embeds"]
      @screenshots = json["screenshots"]
      @external_links = json["external_links"]
    end

    def relationships
      @relationships ||= Relationship.array_from_list(@relationships_list)
    end

    def providerships
      @providerships ||= Relationship.array_from_list(@providerships_list)
    end

    def investments
      @investments ||= Investment.array_from_list(@investments_list)
    end

    def milestones
      @milestones ||= Milestone.array_from_list(@milestones_list)
    end

    def founded?
      !!(@founded_year || @founded_month || @founded_day)
    end
    
    # Returns the date the company was founded, or nil if not provided.
    def founded
      @founded ||= date_from_components(@founded_year, @founded_month, @founded_day)   
    end
    
    # Returns whether the company has a deadpooled date component
    def deadpooled?
      !!(@deadpooled_year || @deadpooled_month || @deadpooled_day)
    end

    # Returns the date the company was deadpooled, or nil if not provided.
    def deadpooled
      @deadpooled ||= date_from_components(@deadpooled_year, @deadpooled_month, @deadpooled_day)
    end
    
    # Returns an array of Product objects, representing this Company's products.
    def products
      @products ||= @products_list.map {|p| Product.get(p['permalink']) }
    end
    
  end
end
