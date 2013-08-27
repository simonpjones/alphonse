module Alphonse
  module Configs
    module Setting

      # TODO: evaluate attributes so allow attribute reuse
      # E.g.
      #   user = "user_name"
      #   path = "/full/path/to/#{user}" => "/full/path/to/user_name"

      def user(value)
        set_attr :user => value
      end

      def hosts(*value)
        set_attr :hosts => [*value].flatten
      end

      def path(value)
        set_attr :path => value
      end

      def git_repo(value)
        set_attr :git_repo => value
      end

      def branch(value)
        set_attr :branch => value
      end

      def env_path(value)
        set_attr :env_path => value
      end

      def ruby_bin_path(value)
        set_attr :ruby_bin_path => value
      end

      def start_command(value)
        set_attr :start_command => value
      end

      def restart_command(value)
        set_attr :restart_command => value
      end

    end
  end
end