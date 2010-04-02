require 'ostruct'
module Depo
  class DijitConventions
    class << self
      attr :props
      def prop(key,&block)
        @props||=[]
        @props<< key
        define_method key,&block
      end
    end

    attr :cmp
    def initialize(dijit_full_name)
      @dijit_full_name= dijit_full_name
      from_full_name(dijit_full_name)
    end

    def from_full_name(dijit_full_name)
      parts = @dijit_full_name.split('.')
      cmps ={:base_module=>parts[0],:class_name=>parts[-1]}
      if parts.length > 2
        cmps[:modules] = parts[1..-2]
      end
      cmps[:dijit_full_name]=dijit_full_name 
      @cmp_hash=cmps
      @cmp = OpenStruct.new(cmps)
    end

    prop :dijit_full_name do
      @dijit_full_name
    end

    prop :dijit_base_class do
      'null'
    end

    prop :dijit_package_name do
      @dijit_full_name.split('.')[0..-2].join('.')
    end

    prop :dijit_class_name do
      cmp.class_name
    end

    prop :dijit_base_module do
      cmp.base_module
    end

    prop :dijit_modules do
      cmp.modules
    end

    def from_src(*args)
      File.join(*args.flatten.unshift(Depo.config.src_path))
    end

    def j(*args)
      File.join(*args)
    end
   
    prop :package_path do
      from_src cmp.base_module, cmp.modules
    end

    prop :style_dir_path do
      from_src cmp.base_module,'themes', Depo.config.default_theme, cmp.modules
    end

    prop :test_dir_path do
      from_src cmp.base_module,'tests', cmp.modules
    end

    prop :class_path do
      j(package_path,"#{cmp.class_name}.js")
    end

    prop :style_path do
      j(style_dir_path,"#{cmp.class_name}.css")
    end

    prop :test_code_path do
      j(test_dir_path,"#{cmp.class_name}.js")
    end

    prop :test_page_path do
      j(test_dir_path,"#{cmp.class_name}.html")
    end

    prop :dijit_style_class_name do
      @dijit_full_name.split('.').map{|c| c.capitalize}.join('')
    end


    def to_hash
      self.class.props.inject({}) do |hash,prp|
        hash[prp] = send(prp); hash;
      end
    end
  end
end
