module Crunchbase
  # Superclass for all relationships. Used for both the relationships and
  # providerships arrays on retrieved objects.
  class Relationship
    
    attr_reader :title
    
    # Takes a relationship list (directly from the JSON hash) and returns an
    # array of instances of Relationship subclasses.
    def self.array_from_list(list)
      list.map do |l|
        if l["person"]
          PersonRelationship.new(l)
        elsif l["firm"]
          FirmRelationship.new(l)
        elsif l["provider"]
          ProviderRelationship.new(l)
        else
          # "Relationship type not recognized"
          # TODO: Figure out how to log this
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
