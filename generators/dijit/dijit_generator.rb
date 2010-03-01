class DijitGenerator < Rails::Generator::Base
  attr :dijit

  def extract_opts!(args)
    @dijit_full_name = args.shift
    @dijit=Depo::DijitConventions.new(@dijit_full_name)
  end

  def assigns
   @assigns ||= {:assigns=>dijit.to_hash.merge(:config=>Depo.config)}
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
      m.directory dijit.package_path
      m.directory dijit.style_dir_path
      m.directory dijit.test_dir_path

      m.template "class.js", dijit.class_path, assigns
      m.template "test.js", dijit.test_code_path,assigns if test?
      m.template "test.html", dijit.test_page_path,assigns if test?
      m.template "style.css", dijit.style_path,assigns if style?
    end
  end
end
