module Depo
  class Config
    attr :root,true

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
  end
end
