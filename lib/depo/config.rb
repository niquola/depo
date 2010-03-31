module Depo
  class Config < KungFigure::Base
    define_prop :root,'public/ria'
    define_prop :author,'NotConfigured'
    define_prop :release_dir,'public/builds'
    define_prop :themes,['tundra']
    define_prop :profile_path,'tmp/dojo_build_profile.js'
    
    def src_path
      "#{root}/src"
    end

    def builds_path
      "#{root}/builds"
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
      define_prop :developmentDjConfig, 'parseOnLoad:true;isDebug:true;'
      define_prop :productionDjConfig, 'parseOnLoad:true;isDebug:false;'
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
