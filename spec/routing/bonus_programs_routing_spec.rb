require "spec_helper"

describe BonusProgramsController do
  describe "routing" do

    it "routes to #index" do
      get("/bonus_programs").should route_to("bonus_programs#index")
    end

    it "routes to #new" do
      get("/bonus_programs/new").should route_to("bonus_programs#new")
    end

    it "routes to #show" do
      get("/bonus_programs/1").should route_to("bonus_programs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bonus_programs/1/edit").should route_to("bonus_programs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bonus_programs").should route_to("bonus_programs#create")
    end

    it "routes to #update" do
      put("/bonus_programs/1").should route_to("bonus_programs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bonus_programs/1").should route_to("bonus_programs#destroy", :id => "1")
    end

  end
end
