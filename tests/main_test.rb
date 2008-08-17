require 'tests/test_helper'

# --------------------------------------------------
# Models
# --------------------------------------------------
describe Meal do

  before(:each) do
    @meal = Factory.build(:meal)
  end

  it "should have a deadline" do
    Factory(:meal, :deadline => Time.now)
    Meal.first.deadline.should.not.be.nil
  end

end
