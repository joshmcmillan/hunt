require 'spec_helper'

describe "hunts/edit" do
  before(:each) do
    @hunt = assign(:hunt, stub_model(Hunt))
  end

  it "renders the edit hunt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hunt_path(@hunt), "post" do
    end
  end
end
