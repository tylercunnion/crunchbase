module Crunchbase
  class EntityListItem
    
    attr_reader :permalink, :namespace
    
    def initialize(json)
      @namespace = json["namespace"]
      if @namespace == "person"
        @first_name = json["first_name"]
        @last_name = json["last_name"]
      else
        @name = json["name"]
      end
      @permalink = json["permalink"]
    end
    
    def first_name
      raise CrunchException, "Not available for this entity" unless namespace == "person"
      @first_name
    end
    
    def last_name
      raise CrunchException, "Not available for this entity" unless namespace == "person"
      @last_name
    end
    
    # Returns concatenation of first and last names if person, otherwise
    # returns name. Thus, if you wanted to, for example, iterate over search
    # results and output the name, you could do so without checking entity type
    # first.
    def name
      if @namespace == "person"
        @first_name + " " + @last_name
      else
        @name
      end
    end

    # Returns the entity associated with the search result, loading from
    # memory if previously fetched, unless +force_reload+ is set to true.
    def entity(force_reload=false)
      return @entity unless @entity.nil? || force_reload
      @entity = case @namespace
      when "company"
        Company.get(@permalink)
      when "financial-organization"
        FinancialOrganization.get(@permalink)
      when "person"
        Person.get(@permalink)
      when "product"
        Product.get(@permalink)
      when "service-provider"
        ServiceProvider.get(@permalink)
      end
      return @entity
    end
      
  end
end