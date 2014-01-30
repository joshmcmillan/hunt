require 'spec_helper'

describe "hunts/index" do
  before(:each) do
    assign(:hunts, [
      stub_model(Hunt),
      stub_model(Hunt)
    ])
  end

  it "renders a list of hunts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
