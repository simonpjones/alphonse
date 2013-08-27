# encoding: utf-8

require 'spec_helper'
require 'alphonse/config'
require 'alphonse/operator'

describe "Operator" do 

  describe "initialised with config" do
    before do
      @config = Alphonse::Config.new(:file_name => 'spec/fonzfiles/default')
      @operator = Alphonse::Operator.new(@config)
    end

    it "should have array of Connections" do
      @operator.send(:hosts).class.should equal(Array)
      @operator.send(:hosts).first.class.should equal(Alphonse::Connection)
    end

    describe "with hosts" do
      before do
        mock_connection!
        @operator.stub(:hosts).and_return([@connection])
      end

      it "should execute setup operation" do
        @operator.execute(:setup).class.should equal(Array)
      end

      it "should execute deploy operation" do
        @operator.execute(:deploy).class.should equal(Array)
      end
    end

  end
end