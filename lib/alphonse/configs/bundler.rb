module Alphonse
  module Configs
    module Bundler
      def bundle_exec(command)
        use_bundle = using_bundler? ? "#{ruby_bin_path}bundle exec " : ""
        "#{use_bundle}#{command}"
      end

      def bundle_install
        "#{ruby_bin_path}bundle install --deployment --without development test" if using_bundler?
      end

      def rake(command)
        bundle_exec "rake #{command}"
      end
      
      private
      
      def using_bundler?
        File.exists? "Gemfile"
      end

      def ruby_bin_path
        config[:ruby_bin_path] rescue nil
      end
    end
  end
end