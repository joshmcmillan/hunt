require "spec_helper"

describe HuntsController do
  describe "routing" do

    it "routes to #index" do
      get("/hunts").should route_to("hunts#index")
    end

    it "routes to #new" do
      get("/hunts/new").should route_to("hunts#new")
    end

    it "routes to #show" do
      get("/hunts/1").should route_to("hunts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hunts/1/edit").should route_to("hunts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hunts").should route_to("hunts#create")
    end

    it "routes to #update" do
      put("/hunts/1").should route_to("hunts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hunts/1").should route_to("hunts#destroy", :id => "1")
    end

  end
end
