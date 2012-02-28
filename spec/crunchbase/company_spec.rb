require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Crunchbase
  describe Company do
    
    it "should pull from web api" do
      company = Company.get("facebook")
      company.name.should == "Facebook"
    end

    it "should find companies by name" do
      company = Company.find("Adobe Systems")
      company.permalink.should == "adobe-systems"
    end
    
    it "should return date for founded" do
      company = Company.new({"founded_year" => 2004, "founded_month" => 2,
        "founded_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      company.founded.should === Date.new(2004, 2, 1)
    end
    
    it "should return date for deadpooled" do
      company = Company.new({"deadpooled_year" => 2004, "deadpooled_month" => 2,
        "deadpooled_day" => 1, "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      company.deadpooled.should === Date.new(2004, 2, 1)
    end
    
    it "should get a complete list" do
      all_companies = Company.all
      all_companies[0].entity.name.should == all_companies[0].name
    end
      
    
  end
end
