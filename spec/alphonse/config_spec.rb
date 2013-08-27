# encoding: utf-8

require 'spec_helper'
require 'alphonse/config'

describe "Config" do 

  describe "with specified Fonzfile" do
    before do
      @config = Alphonse::Config.new(:file_name => 'spec/fonzfiles/default', :test_variable => 1)
    end

    it 'should load the config file' do
      @config.config_loaded?.should be_true
    end

    it 'should have attributes set' do
      @config[:user].should_not be_nil
      @config[:hosts].should_not be_nil
    end

    it 'should be able to access given attributes' do
      @config[:test_variable].should equal(1)
    end

    it 'should set new attributes' do
      @config.set_attr :new_variable => 'new value'
      @config[:new_variable].should == 'new value'
    end

    it 'should re set an attribute' do
      @config.set_attr :test_variable => 2
      @config[:test_variable].should equal(2)
    end

    describe 'calling operator' do
      it 'should initialise and return new operator' do
        @config.operator.should_not be_nil
        @config.operator.class.should equal(Alphonse::Operator)
      end
    end
  end


  describe 'without specified Fonzfile' do
    before do
      @config = Alphonse::Config.new
    end

    it 'should use default Fonzfile' do
      @config.config_loaded?.should be_true
    end

    it 'should have attributes set' do
      @config[:user].should_not be_nil
      @config[:hosts].should_not be_nil
    end

  end


end