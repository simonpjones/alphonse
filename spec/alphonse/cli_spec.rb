# encoding: utf-8

require 'spec_helper'
require 'alphonse/cli'

describe "Cli" do

  describe "with an operation passed" do
   
    before do
      @command = 'deploy'
      @cli = Alphonse::Cli.new(@command.split(' '))
    end
   
    it "should determine the operation to run" do
      @cli.command.should == :deploy
    end

    it "should match the default options" do
      @cli.options.should == { :environment => :production }
    end
  
  end

  describe "with an operation and environment passed" do
   
    before do
      @command = 'deploy -e staging'
      @cli = Alphonse::Cli.new(@command.split(' '))
    end
   
    it "should determine the operation to run" do
      @cli.command.should == :deploy
    end

    it "should match the passed options" do
      @cli.options.should == { :environment => :staging }
    end
  
  end


  describe "with no arguments" do
    it 'should raise an error' do
      lambda { @cli = Alphonse::Cli.new }.should raise_error(Alphonse::CliArgumentError)
    end
  end
  
end