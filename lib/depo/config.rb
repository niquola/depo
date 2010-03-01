module Depo

  class ConfigBase
    class << self
      def define_prop(name,default)
        define_method(name) do |*args|
          @props ||= {}
          if args.length > 0
            @props[name] = args[0]
          else
            @props[name] || default
          end
        end
      end
    end
    def method_missing(key,&block)
      @props ||= {}
      child_cfg_clazz = self.class.const_get(key.to_s.camelize.to_sym)
      if child_cfg_clazz
        if block_given? && !@props.key?(key)
          child_cfg=child_cfg_clazz.new
          child_cfg.instance_eval(&block)
          return @props[key] = child_cfg
        elsif !block_given? && @props.key?(key)
          return @props[key]
        end
      end
      raise "No such configuration #{key}"
    end
  end

  class Config < ConfigBase
    define_prop :root,'public/ria'
    define_prop :author,'NotConfigured'
    define_prop :release_dir,'public/builds'
    define_prop :themes,['tundra']

    def src_path
      "#{root}/src"
    end

    def builds_path
      "#{root}/builds"
    end

    def to_hash
      @props
    end

    class Generators < ConfigBase
      define_prop :head_of_test_page,''
    end

    class Environments < ConfigBase
      define_prop :developmentDjConfig, 'parseOnLoad:true;isDebug:true;'
      define_prop :productionDjConfig, 'parseOnLoad:true;isDebug:false;'
    end

    class BuildProfile < ConfigBase
      define_prop :libs,[]
      define_prop :pages,[]
    end

    class BuildOptions < ConfigBase
      define_prop :cssOptimize,'comments.keepLines'
      define_prop :optimize,'shrinksafe.keepLines'
      define_prop :cssImportIgnore,'../dijit.css'
      define_prop :internStrings, 'false'
    end
  end

end
