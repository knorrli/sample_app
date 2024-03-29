require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user 
      assigns(:user).should == @user
    end
    
    it "should have right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name) 
    end
    
    it "should have the users name" do
      get :show, :id => @user 
      response.should have_selector('td>h1', :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('td>h1>img', :class => "gravatar" )
    end
    
    it "should have the right URL" do
      get :show, :id => @user
      response.should have_selector('td>a', :content => user_path(@user),
                                            :href => user_path(@user))
    end
  end
  

  describe "GET 'new'" do
    
    it "returns http success" do
      get :new
      response.should be_success
    end
  
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "#{@base_title} | Sign Up")
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign Up" )
      end 
      
      it "should render 'new' template" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr   
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {:name => "Test User", :email => "foo@bar.com", :password => "foobar12", :password_confirmation => "foobar12" }
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to user page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Welcome to the Sample app/i
      end
      
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end
end
