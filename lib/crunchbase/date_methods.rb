module Crunchbase
  module DateMethods
    
    # Constructs a Date object from year, month, day, returns nil if it fails
    def date_from_components(year, month, day)
      begin
        date = Date.new(year, month, day)
      rescue
        date = nil
      end
      date
    end
    
  end
end