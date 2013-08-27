require 'optparse'
require 'alphonse/config'

module Alphonse
  class Cli

    attr_reader :command, :options, :argv
    attr_accessor :config

    def self.start(argv = ARGV)
      cli = self.new(argv)
      cli.execute
      cli
    end

    def initialize(argv = [])
      @argv = argv
      @options = { :environment => :production }

      @command = option_parser.parse!(@argv).delete_at(0)
      
      if @command
        @command = @command.to_sym
      else
        raise CliArgumentError, "An operation is required"
      end
    end

    def execute
      case command
      when :init
        Config.init
      else
        config = Config.new(options)
        config.operator.execute(command)
      end
    end

    private

    def option_parser
      @option_parser ||= ::OptionParser.new do |op|
        op.banner = 'Usage: alphonse <command> [options]'      
        op.separator ''

        op.on "-e", "--env ENV", "Environment" do |e|
          @options[:environment] = e.to_sym
        end

        op.on "--verbose", "Verbose" do
          $alphonse_log_level = ::Logger::DEBUG
          @options[:verbose] = true
        end

        op.on "-f", "--file FONZFILE", "Load a different Fonzfile" do |f|
          @options[:file_name] = f || 'Fonzfile' 
        end

        op.on_tail "-h", "--help", "Help" do 
          puts @option_parser
          exit
        end

        op.on_tail "-v", "--version", "Show version" do
          puts "Alphonse v#{Alphonse::Version::STRING}"
          exit
        end

      end
    end

  end
end