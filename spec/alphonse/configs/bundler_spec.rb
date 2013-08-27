# encoding: utf-8

require 'spec_helper'
require 'alphonse/configs/bundler'

describe "Configs::Bundler" do
  before do

    @klass = Class.new do
      include Alphonse::Configs::Bundler
      attr_reader :config

      def initialize
        @config = {}
      end

      def config=(hash)
        @config = hash
      end

    end.new

  end

  after do
    @klass = nil
  end

  describe "with a Gemfile" do
    before do
      @klass.should_receive(:using_bundler?).and_return(true)
    end

    describe "with ruby_bin_path" do
      before do
        @klass.config = {:ruby_bin_path => "path/to/ruby/"}
      end

      describe "when calling bundle_install" do
        it "should return command prepended with ruby_bin_path and bundle exec" do

          @klass.bundle_install.should == "path/to/ruby/bundle install --deployment --without development test"
        end
      end

      describe "when calling rake command" do
        it "should return rake command prepended with ruby_bin_path and bundle exec" do
          @klass.rake("--tasks").should == "path/to/ruby/bundle exec rake --tasks"
        end
      end

    end

  end

  describe "without a Gemfile" do
    before do
      @klass.should_receive(:using_bundler?).and_return(false)
    end

    describe "without ruby_bin_path" do
      before do
        @klass.config = {}
      end

      describe "when calling bundle_install" do
        it "should return command without prepends" do
          @klass.bundle_install.should be_nil
        end
      end

      describe "when calling rake command" do
        it "should return rake command without prepends" do
          @klass.rake("--tasks").should == "rake --tasks"
        end
      end

    end

  end

end