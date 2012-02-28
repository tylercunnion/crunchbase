require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Crunchbase
  describe FinancialOrganization do
    
    it "should pull from web api" do
      finorg = FinancialOrganization.get("robin-hood-ventures")
      finorg.name.should == "Robin Hood Ventures"
    end    

    it "should find by name" do
      f = FinancialOrganization.find("Accel Partners")
      f.permalink.should == "accel-partners"
    end
    
    it "should return date for founded" do
      finorg = FinancialOrganization.new({"founded_year" => 2004, "founded_month" => 2,
        "founded_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      finorg.founded.should === Date.new(2004, 2, 1)
    end
    
    it "should get a complete list" do
      all_fins = FinancialOrganization.all
      all_fins[0].entity.name.should == all_fins[0].name
    end
    
  end
end
