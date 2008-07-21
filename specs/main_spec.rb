require 'specs/spec_helper'

# --------------------------------------------------
# Models
# --------------------------------------------------
describe Meal do

  it "should have a deadline" do
    Factory(:meal, :deadline => Time.now)
    Meal.first.deadline.should_not be_nil
  end

end
