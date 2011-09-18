module Crunchbase
  class FirmRelationship < Relationship
    
    attr_reader :firm_name, :firm_permalink, :firm_type
    
    def self.array_from_relationship_list
      raise CrunchException, "Method must be called from superclass Relationship"
    end
    
    def initialize(hash)
      super(hash)
      @firm_name = hash["firm"]["name"]
      @firm_permalink = hash["firm"]["permalink"]
      @firm_type = hash["firm"]["type_of_entity"]
    end
    
    # Returns a representation of the associated firm, loading from memory
    # if previously fetched, unless force_reload is set to true.
    def firm(force_reload=false)
      return @firm unless @firm.nil? || force_reload
      @firm = case @firm_type
      when "company"
        Company.get(@firm_permalink)
      when "financial_org"
        raise CrunchException, "Not implemented"
      else
        raise CrunchException, "Not implemented"
      end
      return @firm
    end
    
  end
end