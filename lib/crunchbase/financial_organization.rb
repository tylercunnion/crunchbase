module Crunchbase
  class FinancialOrganization < CBObject
    
    def self.get(permalink)
      j = API.financial_organization(permalink)
      f = FinancialOrganization.new(j)
      return f
    end
  end
end