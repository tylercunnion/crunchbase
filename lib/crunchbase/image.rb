module Crunchbase
    class Image
        
        def self.create(hash)
            hash ? self.new(hash) : nil
        end

        attr_reader :attribution, :sizes

        def initialize(hash)
            return nil unless hash
            @attribution = hash['attribution']
            @sizes = hash['available_sizes'].map{|s| ImageSize.new(s)}.sort
        end
    end

    class ImageSize
        include Comparable

        attr_reader :height, :width, :url

        def <=>(anOther)
            pixels <=> anOther.pixels
        end

        def initialize(ary)
            @width = ary[0][0]
            @height = ary[0][1]
            @url = ary[1]
        end
        
        def pixels
            return @width * @height
        end
    end
end
