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
      child_cfg_clazz = self.class.const_get(key.to_s.capitalize.to_sym)
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
  end

end
