require 'spec_helper'

describe "hunts/new" do
  before(:each) do
    assign(:hunt, stub_model(Hunt).as_new_record)
  end

  it "renders new hunt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hunts_path, "post" do
    end
  end
end
