# Borrowed from the test-spec tests.

# Hooray for meta-testing.
module MetaTests
  class ShouldFail < Test::Spec::CustomShould
    def initialize
    end

    def assumptions(block)
      block.should.raise(Test::Unit::AssertionFailedError)
    end

    def failure_message
      "Block did not fail."
    end
  end

  class ShouldSucceed < Test::Spec::CustomShould
    def initialize
    end

    def assumptions(block)
      block.should.not.raise(Test::Unit::AssertionFailedError)
    end

    def failure_message
      "Block raised Test::Unit::AssertionFailedError."
    end
  end

  class ShouldBeDeprecated < Test::Spec::CustomShould
    def initialize
    end

    def assumptions(block)
      block.should._warn
      $WARNING.should =~ /deprecated/
    end

    def failure_message
      "warning was not a deprecation"
    end
  end
  
  module InstanceMethods
    def fail
      ShouldFail.new
    end

    def succeed
      ShouldSucceed.new
    end

    def deprecated
      ShouldBeDeprecated.new
    end
  end
  
  Test::Spec::TestCase::InstanceMethods.send(:include, MetaTests::InstanceMethods)
end
