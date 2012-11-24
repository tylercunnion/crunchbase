module Crunchbase
    module ArrayFromList
        # Takes a list (directly from the JSON hash) and returns an
        # array of instances of the class
        def array_from_list(list)
            list.map {|l| self.new(l) }
        end
    end
end
