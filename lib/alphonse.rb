require "alphonse/version"
require "alphonse/logger"

module Alphonse
  
  # Base class for all Alphonse exceptions
  class AlphonseError < StandardError
  end

  # When a command(s) return a stderr stream
  class StdError < AlphonseError
  end

  # When a configuration file is missing
  class NoFonzfileError < AlphonseError
  end

  # When a host is not defined
  class MissingUserError < AlphonseError
  end

  # When a host is not defined
  class MissingHostError < AlphonseError
  end

  # When an operation is not defined
  class MissingOperationError < AlphonseError
  end

  # When an operation is not defined
  class MissingCommandError < AlphonseError
  end

  # When an operation is invalid
  class InvalidOperationError < AlphonseError
  end

  # When a command is not present or formed corrently
  class CliCommandError < AlphonseError
  end

  # When an argument is not present or well formed
  class CliArgumentError < AlphonseError
  end

end
