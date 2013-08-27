# encoding: utf-8

require 'spec_helper'
require 'alphonse/connection'

describe "Connection" do
  describe "with host and user" do
    before do
      mock_net_ssh_session!
      @connection = Alphonse::Connection.new("localhost", "username", {})
    end

    describe "with given commands" do
      it "should send and excute and return array" do
        session.should_receive(:run).and_return(@result)

        results = @connection.send_and_execute("date")
        results.class.should equal(Array)
      end

      it "should set host and username" do
        @connection.connection_string.should == "username@localhost"
      end

      it "should be able to close session" do
        @connection.close.should equal(true)
      end
    end

    describe "without given commands" do
      it "should return an empty array" do
        result = @connection.send_and_execute()
        result.class.should equal(Array)
        result.empty?.should be_true
      end
    end

    describe "given invalid command" do
      it "shoould raise Alphonse::MalformedCommandError" do
        lambda { @connection.send_and_execute(12) }.should raise_error(Alphonse::MissingCommandError)
      end
    end
  end

  describe "without" do
    describe "host" do
      it "should raise Alphonse::MissingHostError" do
        lambda { Alphonse::Connection.new(nil, "username", {}) }.should raise_error(Alphonse::MissingHostError)
      end
    end

    describe do
      it "should raise Alphonse::MissingUserError" do
        lambda { Alphonse::Connection.new("localhost", nil, {}) }.should raise_error(Alphonse::MissingUserError)
      end
    end
  end
end