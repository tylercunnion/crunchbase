module Crunchbase
  class Investment
    
    include Crunchbase::DateMethods
    
    attr_reader :funding_round_code, :funding_source_url,
      :funding_source_description, :raised_amount, :raised_currency_code, 
      :company_name, :company_permalink
    
    def self.array_from_investment_list(list)
      list.map{|l| self.new(l)}
    end
    
    def initialize(hash)
      hash = hash["funding_round"]
      @funding_round_code = hash["round_code"]
      @funding_source_url = hash["source_url"]
      @funding_source_description = hash["source_description"]
      @raised_amount = hash["raised_amount"]
      @raised_currency_code = hash["raised_currency_code"]
      @funded_year = hash["funded_year"]
      @funded_month = hash["funded_month"]
      @funded_day = hash["funded_day"]
      @company_name = hash["company"]["name"]
      @company_permalink = hash["company"]["permalink"]
    end
    
    # Retrieves associated Company object, storing it for future use.
    # If +force_reload+ is set to true, it will bypass the stored version.
    def company(force_reload=false)
      return @company unless @company.nil? || force_reload
      @company = Company.get(@company_permalink)
      return @company
    end
    
    def funded_date
      @funded_date ||= date_from_components(@funded_year, @funded_month, @funded_day)
    end
      
  end
end