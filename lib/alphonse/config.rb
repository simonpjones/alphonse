require 'alphonse/operator'
require 'alphonse/configs/setting'
require 'alphonse/configs/operation'

module Alphonse
  class Config < Hash
    include Alphonse::Configs::Setting
    include Alphonse::Configs::Operation

    FONZFILE = "./Fonzfile"
    attr_reader :loaded

    # Initialise the Fonzfile
    def self.init
      puts "Fonzie Initialise!"

      pwd = File.dirname(__FILE__)
      if RUBY_VERSION == /1.8/
        require 'ftools'
        File.copy("#{pwd}/default/fonzfile.rb", FONZFILE)
      else
        require 'fileutils'
        ::FileUtils.copy("#{pwd}/default/fonzfile.rb", FONZFILE)
      end
    end

    def initialize(options = {})
      @loaded = false
      self.merge! options
      run_fonzfile
    end

    def operator
      Operator.new(self)
    end


    def set_attr(hash)
      config.merge! hash
    end

    def config
      self
    end

    def config_loaded?
      loaded
    end

    private

    def run_fonzfile
      if fonzfile?
        eval fonzfile.read
        @loaded = true
      else
        raise NoFonzfileError, "No Fonzfile has been found"
      end
    end

    def fonzfile?
      File.exists? config[:file_name] || FONZFILE
    end

    def fonzfile
      File.open config[:file_name] || FONZFILE
    end

  end
end