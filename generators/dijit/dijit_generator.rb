class DijitGenerator < Rails::Generator::Base
  include Depo::PathUtils
  def extract_opts!(args)
    @dijit_full_name = args.shift
  end

  def assigns
   @assigns ||= {:assigns=>{
      :dijit_full_name => @dijit_full_name,
      :dijit_class_name => dijit_class_name(@dijit_full_name),
      :dijit_package_name => dijit_package_name(@dijit_full_name),
      :dijit_base_class => @dijit_base_class || 'null',
      :dijit_style_class_name => dijit_style_class_name(@dijit_full_name)
    }.merge(Depo.config.to_hash)}
  end

  def test?
    true
  end

  def style?
    true
  end

  def manifest
    record do |m|
      extract_opts!(args)
      m.directory package_path(@dijit_full_name)
      m.directory style_dir_path(@dijit_full_name)
      m.directory test_dir_path(@dijit_full_name)

      m.template "class.js", class_path(@dijit_full_name), assigns
      #m.template "style.css", style_path(@dijit_full_name),assigns if style?
      #m.template "test.js", test_code_path(@dijit_full_name),assigns if test?
      #m.template "test.htm", test_page_path(@dijit_full_name),assigns if test?
    end
  end
end
