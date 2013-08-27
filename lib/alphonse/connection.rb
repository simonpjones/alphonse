# encoding: utf-8

require "net/ssh/session"

module Alphonse
  class Connection

    attr_reader :host, :user, :session, :config
    def initialize(host, user, config)
      @config = config
      @host = host
      @user = user
      
      raise Alphonse::MissingUserError, "User has not been specified" unless user
      raise Alphonse::MissingHostError, "Host has not been specified" unless host
      
      @session = Net::SSH::Session.new(host, user)
    end

    def connection_string
      "#{user}@#{host}"
    end

    def send_and_execute(command = "")
      commands = parse(command)

      session.open(10)
      
      results = []
      commands.each do |cmd|
        Alphonse.logger.task cmd
        result = session.run(cmd)
        results << result
        if result.failure?
          Alphonse.logger.error result.output
          break
        else
          Alphonse.logger.debug result.output if config[:verbose]
          Alphonse.logger.info "Completed in #{result.duration}s"
        end
        
      end
      results
    end


    def close
      session.close
    end
    
    private 
    
    def parse(command)
      case command.class.name
      when 'String'
        command == '' ? [] : [command.chomp]
      when 'Array'
        command.compact.flatten
      else
        raise Alphonse::MissingCommandError, "Command Not a String or Array: #{command.inspect}"
      end
    end

  end
end