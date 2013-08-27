# encoding: utf-8

require 'spec_helper'
require 'alphonse/configs/operation'

describe "Configs::Operation" do
  before do
    @klass = Class.new do
      include Alphonse::Configs::Operation
      include Alphonse::Configs::Tasks
      attr_reader :config

      def initialize
        @config = {}
      end

      def config=(hash)
        @config = hash
      end

      def set_attr(hash)
        config.merge! hash
      end

    end.new

    @test_tasks = [:source_shell_rc, :git_pull]
  end

  after do
    @klass = nil
  end

  describe "Given operation and tasks" do
    before do
      @klass.operation :test_operation, "Test Operation Deascription"
      @klass.tasks(@test_tasks)
    end

    it "should set given tasks in operation key of config" do
      @klass.config[:test_operation].should == @test_tasks
    end

    it "should set given description in config" do
      @klass.config[:test_operation_description].should_not be_nil
    end

    describe "Calling tasks" do
      it "should return commands as strings" do
        task = @klass.config[:test_operation].first
        @klass.send(task).should == "source ~/.bashrc"

        task = @klass.config[:test_operation].last
        @klass.send(task).should == ["git checkout master -q", "git pull origin master -q", "git gc --aggressive"]
      end
    end
  end
end