require File.join(File.dirname(__FILE__), '../test_helper.rb')
require 'test/spec/extended/should_change'

class Foo
  def initialize(bar=nil); self.bar = bar; end
  attr_accessor :bar
end

describe "should change(obj, msg)" do
  before(:each) do
    @instance = Foo.new(1)
  end
  
  it "should pass when the block changes the value" do
    lambda {
      lambda { @instance.bar += 1 }.should change(@instance, :bar)
    }.should succeed
    
  end
  
  it "should fail when block doesn't change the value" do
    lambda {
      lambda { }.should change(@instance, :bar)
    }.should fail
  end
  
  it "should pass with strings" do
    @instance.bar = 'string'
    lambda {
      lambda { @instance.bar = 'xstring' }.should change(@instance, :bar)
    }.should succeed
  end
end

describe "should.not change(obj, msg)" do
  before(:each) do
    @instance = Foo.new(1)
  end
  
  it "should pass when the block does not change the value" do
    lambda {
      lambda { }.should.not change(@instance, :bar)
    }.should succeed
  end
  
  it "should pass when block doesn't change the value" do
    lambda {
      lambda { }.should change(@instance, :bar)
    }.should fail
  end
end

describe "should change(obj, msg).by(amount)" do
  before(:each) do
    @instance = Foo.new(1)
  end
  
  it "should pass when the block changes the value by the amount" do
    lambda {
      lambda { @instance.bar +=2 }.should change(@instance, :bar).by(2)
    }.should succeed
  end
  
  it "should pass with any type of object that supports the difference operator" do
    @instance.bar = [1]
    lambda {
      lambda { @instance.bar = [1, 2] }.should change(@instance, :bar).by([2])
    }.should succeed
  end
  
  it "should fail when the block doesn't change the value by the amount" do
    lambda {
      lambda { @instance.bar +=1 }.should change(@instance, :bar).by(2)
    }.should fail
  end
  
  it "should error if obj.msg does not support difference operator" do
    @instance.bar = 'string'
    lambda {
      lambda { }.should change(@instance, :bar).by('x')
    }.should.raise Test::Spec::DefinitionError
  end
end

describe "should.not change(obj, msg).by(amount)" do
  it "should error" do
    lambda {
      lambda { }.should.not change(Foo.new(1), :bar).by(1)
    }.should.raise Test::Spec::DefinitionError
  end
end
