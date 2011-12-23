require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have right title" do
      get :new
      response.should have_selector('title', :content => "Sign In") 
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = {:email => "", :password => ""}
      end
      
      it "should re-render the 'new' page" do
        post :create, :session => @attr
        response.should be_success
      end
      
      it "should have right title" do
        post :create, :session => @attr
        response.should have_selector('title', :content => "Sign In") 
      end
      
      it "should have an error message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /do not match/i
      end
    end
    
    describe "success" do
      
      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email, :password => @user.password}
      end
      
      it "should sign in the user" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should redirect to user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
      
    end
    
  end

end
