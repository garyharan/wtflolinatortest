require 'specs/spec_helper'

describe Meal do

  it "should have deadline" do
    @meal = Meal.create(:deadline => Time.now)
    @meal.deadline.should_not be_nil
  end

end
