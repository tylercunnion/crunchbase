require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'json'

module Crunchbase
  describe Person do
    
    it "should build from a permalink" do
      person = Person.get("brad-fitzpatrick")
      person.first_name.should == "Brad"
    end
    
    it "should ask for JSON object" do
      f = File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "brad-fitzpatrick.js"))
      API.should_receive(:person).with("brad-fitzpatrick").and_return(JSON.parse(f.read))
      person = Person.get("brad-fitzpatrick")
    end
  end
end