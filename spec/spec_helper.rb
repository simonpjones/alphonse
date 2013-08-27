$:.push File.expand_path("../lib", __FILE__)


require 'alphonse'
require 'rspec'

RSpec.configure do |config|
  # config
end

def mock_connection!
  @connection = double('connection')
  @connection.stub(:send_and_execute).and_return([])
  @connection.stub(:connection_string).and_return("connection_string")
  @connection.stub(:close).and_return(true)
end

def mock_net_ssh_session!
  @result = double('result')
  @result.stub(:failure?).and_return(:false)
  @result.stub(:output).and_return("Output")
  @result.stub(:duration).and_return(100)
  @session = double("session")
  @session.stub(:close).and_return(true)
  @session.stub(:open).and_return(true)
  @session.stub(:run).and_return(@result)
  Net::SSH::Session.stub(:new).and_return(@session)
end


def connection
  @connection
end

def session
  @session
end