require "chef/handler"
Gem.clear_paths
gem "minitest", "2.3.1"
require "minitest/unit"

class ChefMiniTestRunner < MiniTest::Unit
  def before_suites
    Chef::Log.info "ChefMiniTestRunner starting"
  end

  def after_suites
    Chef::Log.info "ChefMiniTestRunner completed"
  end

  def _run_suites(suites, type)
    begin
      before_suites
      super(suites, type)
    ensure
      after_suites
    end
  end

  def _run_suite(suite, type)
    begin
      suite.before_suite if suite.respond_to?(:before_suite)
      super(suite, type)
    ensure
      suite.after_suite if suite.respond_to?(:after_suite)
    end
  end
end

module ChefMiniTest
  class Handler < ::Chef::Handler
    def report
     MiniTest::Unit.runner = ChefMiniTestRunner.new
      run_status.updated_resources.select do |resource|
        next unless resource.resource_name == :minitest_unit_testcase and resource.respond_to? :block and !resource.block.nil?
        testcase = Class.new(MiniTest::Unit::TestCase)
        testcase.class_eval do
          define_method resource.name, &resource.block
        end
      end
      MiniTest::Unit.new.run(["-v"])
    end
  end
end
