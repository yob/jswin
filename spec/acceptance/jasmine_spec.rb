require 'spec_helper'

MSG = "at least 1 jasmine spec failed. Visit /jasmine in a browser for more detail"

describe "Jasmine specs", :js => true, :type => :acceptance do

  it "should all run and pass" do
    visit "/jasmine"
    page.should have_content("spec, 0 failures"), MSG
  end

end
