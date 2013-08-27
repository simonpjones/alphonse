# encoding: utf-8

require 'spec_helper'
require 'alphonse/configs/setting'

describe "Configs::Setting" do
  before do
    @klass = Class.new do
      include Alphonse::Configs::Setting
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
  end

  after do
    @klass = nil
  end

  describe "with a single given value for an attribute" do
    before do
      @klass.user("user_name")
    end

    it "should set correct attribute" do
      @klass.config[:user].should == "user_name"
    end
  end

  describe "with an array of values given for an attribute" do
    before do
      @klass.hosts(["host.address", "alt_host.address"])
    end

    it "should set attribute with correct values" do
      @klass.config[:hosts].should == ["host.address", "alt_host.address"]
    end
  end


end