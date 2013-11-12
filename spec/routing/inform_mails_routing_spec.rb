require "spec_helper"

describe InformMailsController do
  describe "routing" do

    it "routes to #index" do
      get("/inform_mails").should route_to("inform_mails#index")
    end

    it "routes to #new" do
      get("/inform_mails/new").should route_to("inform_mails#new")
    end

    it "routes to #show" do
      get("/inform_mails/1").should route_to("inform_mails#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inform_mails/1/edit").should route_to("inform_mails#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inform_mails").should route_to("inform_mails#create")
    end

    it "routes to #update" do
      put("/inform_mails/1").should route_to("inform_mails#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inform_mails/1").should route_to("inform_mails#destroy", :id => "1")
    end

  end
end
