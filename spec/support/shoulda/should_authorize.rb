# Ensures the model has an attr_accessor, attr_reader or attr_writer
# Examples:
#   it { should_authorize(Model, :method, :via => :http_method, :parameters) }
#   it { should_authorize(User, :index) }
#   it { should_authorize(an_instance_of(Idea), :create, :via => :post, :idea => {:name => 'idea'} ) }

module Shoulda
  module Matchers
    module ActiveModel # :nodoc

      def should_authorize(target, method, options={})
        options[:via] ||= :get

        if ![:get, :post, :put, :delete].include? options[:via]
          fail "#{options[:via]} is not a valid http method"
        end
        http_method = options.delete(:via)

        controller.should_receive(:authorize!).with(method, target)
        send(http_method, method, options)
      end

    end
  end
end