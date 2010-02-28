require 'ostruct'
module Depo
  module PathUtils

    def from_full_name(dijit_full_name)
      parts = dijit_full_name.split('.')
      cmp ={:base_module=>parts[0],:class_name=>parts[-1]}
      if parts.length > 2
        cmp[:modules] = parts[1..-2]
      end
      OpenStruct.new(cmp)
    end

    def from_src(*args)
      File.join(*args.flatten.unshift(Depo.config.src_path))
    end

    def j(*args)
      File.join(*args)
    end

    def package_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      from_src cmp.base_module, cmp.modules
    end

    def style_dir_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      from_src cmp.base_module,'themes','basic', cmp.modules
    end

    def test_dir_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      from_src cmp.base_module,'tests', cmp.modules
    end

    def class_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      j(package_path( dijit_full_name),"#{cmp.class_name}.js")
    end

    def style_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      j(style_dir_path( dijit_full_name),"#{cmp.class_name}.css")
    end

    def test_code_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      j(test_dir_path( dijit_full_name),"#{cmp.class_name}.js")
    end

    def test_page_path(dijit_full_name)
      cmp = from_full_name(dijit_full_name)
      j(test_dir_path( dijit_full_name),"#{cmp.class_name}.html")
    end

    def dijit_style_class_name(dijit_full_name)
      dijit_full_name.split('.').map{|c| c.capitalize}.join('')
    end

    def dijit_package_name(dijit_full_name)
      dijit_full_name.split('.')[0..-2].join('.')
    end

    def dijit_class_name(dijit_full_name)
      from_full_name(dijit_full_name).class_name
    end

    self.extend self
  end
end
