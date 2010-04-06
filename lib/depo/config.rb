module Depo
  class Config < KungFigure::Base
    define_prop :root,'public/ria'
    define_prop :webroot,'public'
    define_prop :base_webpath,''
    define_prop :author,'NotConfigured'
    define_prop :themes,['tundra']
    define_prop :default_theme,'tundra'
    define_prop :profile_path,'tmp/dojo_build_profile.js'
    define_prop :default_page_lib,'app.pages'
    define_prop :dojo_version,'1.4.102'
    define_prop :enable_dojofy, true

    def src_path
      "#{root}/src"
    end

    def builds_path
      "#{root}/builds"
    end

    def root_webpath
      "#{base_webpath}#{root.gsub(webroot, "")}"
    end

    def src_webpath
      "#{base_webpath}#{src_path.gsub(webroot, "")}"
    end

    def last_build_webpath
     "#{base_webpath}#{(Dir[File.join(builds_path,'*')].max).to_s.gsub(webroot, "")}"
    end

    def env_dj_config(env)
      return (env == "production") ? environments.productionDjConfig : environments.developmentDjConfig
    end

    def env_root_webpath(env)
      return (env == "production") ? last_build_webpath : src_webpath
    end

    def buildscripts_path
      File.join(src_path,'util','buildscripts')
    end

    def to_hash
      @props
    end

    class Generators < KungFigure::Base
      define_prop :head_of_test_page,''
    end

    class Environments < KungFigure::Base
      define_prop :developmentDjConfig, 'parseOnLoad:true,isDebug:true'
      define_prop :productionDjConfig, 'parseOnLoad:true,isDebug:false'
    end

    class BuildProfile < KungFigure::Base
      define_prop :libs,[]
      define_prop :pages,[]
    end

    class BuildOptions < KungFigure::Base
      define_prop :cssOptimize,'comments.keepLines'
      define_prop :optimize,'shrinksafe.keepLines'
      define_prop :cssImportIgnore,'../dijit.css'
      define_prop :internStrings, 'false'

      #FIXME: fix kung_figure to do such things simpler
      def get_options
        {
          :cssOptimize => cssOptimize,
          :optimize=> optimize,
          :cssImportIgnore=>cssImportIgnore,
          :internStrings=>internStrings
        }
      end
    end
  end

end
