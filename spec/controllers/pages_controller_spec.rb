require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  
    it "should have the right title" do
      get "home"
      response.should have_selector("title", :content => "Rails Sample app | Home")
    end
    
    it "should have non-black body" do
      get "home"
      response.body.should_not =~ /<body>\s*<\/body>/
    end
    
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get "contact"
      response.should have_selector("title", :content => "Rails Sample app | Contact")
    end
    
    it "should have non-black body" do
      get "contact"
      response.body.should_not =~ /<body>\s*<\/body>/
    end
       
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get "about"
      response.should have_selector("title", :content => "Rails Sample app | About")
    end
    
    it "should have non-black body" do
      get "about"
      response.body.should_not =~ /<body>\s*<\/body>/
    end
    
  end
  
end
