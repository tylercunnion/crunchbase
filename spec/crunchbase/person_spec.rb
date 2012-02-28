require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")
require 'json'

module Crunchbase
  describe Person do
    
    before(:all) do
      @steve = File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "steve-jobs.js"))
      @brad = File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "brad-fitzpatrick.js"))
    end
    
    before(:each) do
      @steve.rewind
      @brad.rewind
    end 
    
    it "should ask for JSON object" do
      API.should_receive(:single_entity).with("brad-fitzpatrick", "person").and_return(JSON.parse(@brad.read))
      person = Person.get("brad-fitzpatrick")
    end
    
    it "should get information from supplied file" do
      API.should_receive(:single_entity).with("steve-jobs", "person").and_return(JSON.parse(@steve.read))
      person = Person.get("steve-jobs")
      person.first_name.should == "Steve"
      
      API.should_receive(:single_entity).with("brad-fitzpatrick", "person").and_return(JSON.parse(@brad.read))
      person = Person.get("brad-fitzpatrick")
      person.first_name.should == "Brad"
    end
    
    it "should return a date for born" do
      person = Person.new(JSON.parse(@steve.read))
      date = Date.new(1955, 2, 24)
      person.born.should === date
    end
    
    it "should return nil when birthday is unavailable" do
      person = Person.new({ 
        "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      person.born.should be_nil
    end    
    
    it "should get an array of tags" do
      person = Person.new({"tag_list" => "computers, technology", 
        "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      person.tags.should == ["computers", "technology"]
    end
    
    it "should return empty array for null tags" do
      person = Person.new({"tag_list" => nil, 
        "created_at" => "Sat Dec 22 08:42:28 UTC 2007",
        "updated_at" => "Sat Dec 22 08:42:28 UTC 2007"})
      person.tags.should == []
    end
    
    it "should get from web" do
      person = Person.get("steve-jobs")
      person.first_name.should == "Steve"
    end

    it "should find a person by name" do
      person = Person.find("Steve", "Jobs")
      person.permalink.should == "steve-jobs"
    end
    
    it "should be equal to another with the same permalink and last updated" do
      person = Person.get("steve-jobs")
      person2 = Person.get("steve-jobs")
      person.should === person2
    end
    
    it "should get a complete list" do
      all_people = Person.all
      all_people[0].entity.first_name.should == all_people[0].first_name
      all_people[0].entity.last_name.should == all_people[0].last_name
    end
    
  end
end
