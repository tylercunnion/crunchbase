module Crunchbase
  # Superclass for all relationships. Used for both the relationships and
  # providerships arrays on retrieved objects.
  class Relationship
    
    attr_reader :title
    
    # Takes a relationship list (directly from the JSON hash) and returns an
    # array of instances of Relationship subclasses. Raises CrunchException if
    # the relationship is not one of the recognized types.
    def self.array_from_relationship_list(list)
      list.map do |l|
        if l["person"]
          PersonRelationship.new(l)
        elsif l["firm"]
          FirmRelationship.new(l)
        elsif l["provider"]
          ProviderRelationship.new(l)
        else
          #raise CrunchException, "Relationship type not recognized"
          next
        end
      end
    end
    
    def initialize(hash)
      @is_past = hash["is_past"]
      @title = hash["title"]
    end
    
    # Convenience method, returns opposite of is_past?
    def current?
      !@is_past
    end
    
    def is_past?
      @is_past
    end    
  end
end