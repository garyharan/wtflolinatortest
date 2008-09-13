module ShouldChange
  class Change < Test::Spec::CustomShould
    attr_reader :by_used
    
    def initialize(receiver, message)
      @receiver = receiver
      @message = message
    end
    
    def matches?(*args)
      return false unless args.first.is_a? Proc
      block = args.shift
      @before = @receiver.send(@message)
      block.call
      @after = @receiver.send(@message)
      return @amount == delta if @amount
      return @after != @before
    end
    
    def by(amount)
      unless @receiver.send(@message).respond_to? :- then
        raise Test::Spec::DefinitionError,
              "object type must support difference operator to test changing by a certain value" 
      end
      @by_used = true
      @amount = amount
      self
    end

    private
      def delta
        @after - @before
      end
  end

  Test::Spec::TestCase::InstanceMethods.class_eval do
    def change(receiver, message)
      Change.new(receiver, message)
    end
  end

  Test::Spec::ShouldNot.class_eval do
    def pass(custom)
      _wrap_assertion {
        begin
          raise Test::Spec::DefinitionError if custom.by_used
          assert !custom.matches?(@object), @message || custom.failure_message
        end
      }
    end
  end
end