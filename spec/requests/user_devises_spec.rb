require 'spec_helper'

describe "UserDevises" do
  let!(:user) { FactoryGirl.create :user }
  describe "when user not sign in" do
    before do
      get root_path
    end 
    subject { response }
    its(:status) { should be(302) }
  end
  describe "user sign in" do
    it "allows users to sign in after they have registered" do
      visit new_user_session_path
      fill_in :user_email,    :with => user.email
      fill_in :user_password, :with => user.password
      click_button "Sign in"
      page.should have_content("Signed in successfully.")
    end
  end
end
