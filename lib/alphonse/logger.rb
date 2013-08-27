# encoding: utf-8

require 'logger'

module Alphonse

  class Logger < ::Logger
    TASK = 6
    SUCCESS = 7
    OPERATION = 8

    LABELS = %w(DEBUG INFO WARN ERROR FATAL ANY TASK SUCCESS OPERATION)

    def task(progname = nil, &block)
      add(TASK, nil, progname, &block)
    end

    def success(progname = nil, &block)
      add(SUCCESS, nil, progname, &block)
    end

    def operation(progname = nil, &block)
      add(OPERATION, nil, progname, &block)
    end

    private

    def format_severity(severity)
      LABELS[severity] || 'ANY'
    end

  end
  

  class LogFormat

    COLOURS = { 
      :black    => 30,
      :red      => 31, 
      :green    => 32, 
      :yellow   => 33,
      :blue     => 34,
      :magenta  => 35,
      :cyan     => 36,
      :white    => 37
    }

    def call(severity, datetime, progname, message)
      
      case severity
      when "DEBUG"
        colour("#{progname}::#{severity} - #{message}\n", :yellow)
      when "WARN"
        colour("#{progname}::#{severity} - #{message}\n", :yellow)
      when "TASK"
        colour("#{progname}::#{severity} - #{underline(message)}\n", :magenta)
      when "SUCCESS"
        colour("#{progname}::#{severity} - #{underline(message)}\n", :green)
      when "OPERATION"
        colour("#{progname}::#{severity} - #{underline(message)}\n", :cyan)
      when "ERROR", "FATAL"
        colour("#{progname}::#{severity} - #{underline(message)}\n", :red)
      else
        "#{progname}::#{severity} - #{message}\n\n"
      end
    end

    private

    def colour(msg, clr = :black)
      "\e[#{COLOURS[clr]}m#{msg}\e[0m"
    end

    def underline(message)
      "\e[4m#{message}\e[0m"
    end
    
  end

  def self.logger
    @logger ||= begin
      logger = Logger.new($stdout)
      logger.level = $alphonse_log_level || ::Logger::INFO
      logger.progname = 'Alphonse'
      logger.formatter = LogFormat.new
      logger
    end
  end


end