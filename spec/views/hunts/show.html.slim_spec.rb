require 'spec_helper'

describe "hunts/show" do
  before(:each) do
    @hunt = assign(:hunt, stub_model(Hunt))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
