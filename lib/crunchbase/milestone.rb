module Crunchbase
    class Milestone
        attr_reader :description, :source_url, :source_text, 
            :source_description, :stoneable_type, :stoned_value,
            :stoned_value_type, :stoned_acquirer

        include Crunchbase::DateMethods

        def initialize(obj)
            @description = obj['description']
            @stoned_year = obj['stoned_year']
            @stoned_month = obj['stoned_month']
            @stoned_day = obj['stoned_day']
            @source_url = obj['source_url']
            @source_text = obj['source_text']
            @source_description = obj['source_description']
            @stoneable_type = obj['stoneable_type']
        end

        def date 
            @date ||= date_from_components(@stoned_year, @stoned_month, @stoned_day)
        end
    end
end
