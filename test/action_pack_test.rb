require File.dirname(__FILE__) + '/test_helper.rb'

class ActionView
  include Depo::ViewHelpers
end

class ActionViewEnv
  attr_accessor :av_values
  def css
    @av_values[:css]
  end
  def app_js
    @av_values[:app_js]
  end
  def webroot
    @av_values[:webroot]
  end
  def djConfig
    @av_values[:djConfig]
  end
  def get_template(v)
    @av_values = v
    tpl_string = IO.readlines(File.dirname(__FILE__) + '/../lib/depo/templates/dojo_src.tpl').to_s
    tpl = ERB.new(tpl_string).result(binding)
  end
end

class ActionPackTest < GeneratorTest
  def test_dojo_helper_development
    assert_equal ActionView.new.dojo(:app => 'app', :env => 'development'), ActionViewEnv.new.get_template({
      :webroot => "ria/src",
      :app_js => "ria/src/app/pages/app.js",
      :djConfig => "parseOnLoad:true,isDebug:true",
      :css => "ria/src/app/themes/tundra/app.css"
    })
  end

  def test_dojo_helper_production
    build_path = File.join(Depo.config.builds_path, 'builddir')
    Dir::mkdir(Depo.config.builds_path) if !File.directory? Depo.config.builds_path
    Dir::mkdir(build_path) if !File.directory? build_path
    assert_equal ActionView.new.dojo(:app => 'app', :env => 'production'), ActionViewEnv.new.get_template({
      :webroot => "ria/builds/builddir",
      :app_js => "ria/builds/builddir/app/pages/app.js",
      :djConfig => "parseOnLoad:true,isDebug:false",
      :css => "ria/builds/builddir/app/themes/tundra/app.css"
    })
  end
end
