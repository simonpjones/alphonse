require 'alphonse/connection'
require 'alphonse/configs/operation'
require 'alphonse/configs/bundler'

module Alphonse
  class Operator
    include Alphonse::Configs::Tasks
    include Alphonse::Configs::Bundler
    attr_reader :config

    def initialize(config = {})
      @config = config
    end

    def execute(command)
      hosts.each do |host_connection|
        begin
          Alphonse.logger.info "\e[4mRunning on #{host_connection.connection_string}\e[0m"
          
          host_connection.send_and_execute send(command)

          Alphonse.logger.success "Aaaaaay! All Actions Completed"
        rescue Exception => e
          Alphonse.logger.error "#{e.class.to_s} : #{e.message}\n\n#{e.backtrace.join("\n")}"
          break
        ensure
          host_connection.close
        end
      end
    end

    private

    # Create and setup folder on remote server
    def setup
      Alphonse.logger.operation config[:setup_description]
      prerequisite.push config[:setup].map { |task| send task }
    end

    # First time deploy of app to remote server
    def deploy
      Alphonse.logger.operation config[:deploy_description]
      prerequisite.push config[:deploy].map { |task| send(task) }
    end

    # Issue bundle command on remote server
    def bundle_update
      Alphonse.logger.operation config[:bundle_description]
      prerequisite.push config[:bundle_update].map { |task| send(task) }
    end

    # Pull latest on remote server
    def update
      Alphonse.logger.operation config[:update_description]
      prerequisite.push config[:update].map { |task| send(task) }
    end

    # Restart the app
    def restart
      Alphonse.logger.operation config[:restart_description]
      prerequisite.push config[:restart].map { |task| send(task) }
    end

    def prerequisite
      [cd_to_path]
    end

    def hosts
      @hosts ||= begin
        host_connections, hosts, user = [], (config[:hosts] rescue nil), (config[:user] rescue nil)
        hosts.each {|host| host_connections << Connection.new(host, user, config) } if hosts && user; 
        host_connections
      end
    end


  end
end