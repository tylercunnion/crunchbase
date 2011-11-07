module Crunchbase
  class ProviderRelationship < Relationship
    
    attr_reader :provider_name, :provider_permalink
    
    def self.array_from_relationship_list #:nodoc:
      raise CrunchException, "Method must be called from superclass Relationship"
    end
    
    def initialize(hash)
      super(hash)
      @provider_name = hash["provider"]["name"]
      @provider_permalink = hash["provider"]["permalink"]
    end
    
    # Returns a representation of the associated person, loading from memory
    # if previously fetched, unless force_reload is set to true.
    def provider(force_reload=false)
      return @provider unless @provider.nil? || force_reload
      @provider = ServiceProvider.get(@provider_permalink)
    end
    
  end
end