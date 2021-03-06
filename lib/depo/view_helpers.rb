module Depo

  module ViewHelpers

    def webroot
      Depo.config.env_root_webpath(@opts[:env])
    end

    def djConfig
      Depo.config.env_dj_config(@opts[:env])
    end

    def app_package
      @app_package||=Depo.config.app_package
    end

    #check if ext presented and add if not
    def add_ext(str,ext)
      ( str.strip=~/\.#{ext}$/ ) ? str.strip : "#{str.strip}.#{ext}"
    end

    def css
      %Q[#{webroot}/#{app_package}/themes/#{theme}/#{add_ext(@opts[:app],'css')}]
    end

    def dojo(opts)
      return @dojo_tpl if @dojo_tpl
      raise "You must provide :app name in opts" unless opts[:app] 
      @opts = opts
      @opts[:env] = (defined? RAILS_ENV && !opts[:env])? RAILS_ENV : opts[:env]
      tpl_string = File.read("#{File.dirname(__FILE__)}/templates/dojo_src.tpl")
      @dojo_tpl = ERB.new(tpl_string).result(binding)
    end

    def theme
      Depo.config.default_theme
    end

    def app_js
      %Q[#{webroot}/#{app_package}/pages/#{@opts[:app]}.js]
    end

  end
end
