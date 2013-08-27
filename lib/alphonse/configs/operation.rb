module Alphonse
  module Configs
    module Operation
      
      attr_reader :command, :description

      def operation(name, description, &block)
        @command = name
        set_attr "#{command}_description".to_sym => description
        block.call if block_given?
      end

      def tasks(*args)
        set_attr command.to_sym => args.flatten
      end

    end

    module Tasks
      # For testing only
      def list
        "ls -a"
      end
      alias :ls :list

      def branch
        config[:branch] || 'master'
      end

      def repository
        config[:git_repo]
      end

      def set_path_variable
        ["export PATH=#{config[:env_path]}"]
      end

      def source_shell_rc
        "source ~/.bashrc"
      end

      def start_app
        (config[:start_command] || 'touch tmp/restart.txt')
      end

      def restart_app
        (config[:restart_command] || 'touch tmp/restart.txt')
      end

      def mkdir_path
        "mkdir -p #{config[:path]}"
      end
      alias :setup_directory :mkdir_path

      def cd_to_path
        "cd #{config[:path]}"
      end
      alias :cd :cd_to_path

      def git_pull
        ["git checkout #{branch} -q", "git pull origin #{branch} -q", "git gc --aggressive"]
      end
      alias :gl :git_pull
      alias :update_repository :git_pull

      def git_clone
        "git clone #{repository} #{config[:path]}"
      end
      alias :gc :git_clone
      alias :clone_repository :git_clone

      def bundle
        bundle_install
      end
      alias :install_gems :bundle

      def db_setup
        rake("db:setup RAILS_ENV=#{config[:environment]}")
      end
      alias :setup_database :db_setup

      def db_migrate
        rake("db:migrate RAILS_ENV=#{config[:environment]}")
      end
      alias :update_database :db_migrate


    end
  end
end