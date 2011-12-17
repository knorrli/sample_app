require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :name => "TestUser",
      :email => "test@example.com",
      :password => "password",
      :password_confirmation => "password"
      }
  end
  
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should reqire a name" do
    user = User.new(@attr.merge(:name => ""))
    user.should_not be_valid
  end
  
  it "should reqire an email address" do
    user = User.new(@attr.merge(:email => ""))
    user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    user = User.new(@attr.merge(:name => long_name))
    user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[foo.bar@batarang.com DANI@dani.jp test_tata@test.dani.org]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject email addresses" do
    addresses = %w[foo.bar@batarang,com DANIdani.jp test_tata@test.gsbgr.f.d.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
     @user.should respond_to(:password)
    end
    
    it "should have a password confirmation" do
      @user.should respond_to(:password_confirmation)
    end
    
  end
  
  describe "password validation" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 51
      User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
    
    it "should have a salt" do
      @user.should respond_to(:salt)
    end
    
    describe "has_password? method" do
      
      it "should exist" do
        @user.should respond_to(:has_password?)
      end
      
      it "should return true if passwords match" do
        @user.has_password?("password").should be_true
      end
      
      it "should return false if passwords don't match" do
        @user.has_password?("foobar").should be_false
      end
      
    end
    
    describe "authenticate method" do
      
      it "should exist" do
        User.should respond_to(:authenticate)
      end
      
      it "should return nil on email/password mismatch" do
        User.authenticate(@attr[:email], "donkey").should be_nil
      end
      
      it "should return nil for an email address with no user" do
        User.authenticate("test@test.com", @attr[:password]).should be_nil
      end
      
      it "should return the user on email/password match" do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end
    
    
  end
  
end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

