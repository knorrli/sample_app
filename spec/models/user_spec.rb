# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {:name => "TestUser", :email => "test@example.com"}
  end
  
  
  it "should create a new instance given a valid attribute" do
    User.create!(:name => "Test", :email => "test@example.com")
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
  
end

