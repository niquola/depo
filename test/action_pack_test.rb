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
    tpl_string = File.read(File.dirname(__FILE__) + '/../lib/depo/templates/dojo_src.tpl')
    tpl = ERB.new(tpl_string).result(binding)
  end
end

class ActionPackTest < GeneratorTest
  def test_dojo_helper_development
    assert_equal ActionView.new.dojo(:app => 'app', :env => 'development'), ActionViewEnv.new.get_template({
      :webroot => "/ria/src",
      :app_js => "/ria/src/app/pages/app.js",
      :djConfig => "parseOnLoad:true,isDebug:true",
      :css => "/ria/src/app/themes/tundra/app.css"
    })
    Depo.clear_config!
  end

  def test_dojo_helper_production
    create_if_missing(File.join(Depo.config.builds_path, 'builddir'))
    assert_equal ActionView.new.dojo(:app => 'app', :env => 'production'), ActionViewEnv.new.get_template({
      :webroot => "/ria/builds/builddir",
      :app_js => "/ria/builds/builddir/app/pages/app.js",
      :djConfig => "parseOnLoad:true,isDebug:false",
      :css => "/ria/builds/builddir/app/themes/tundra/app.css"
    })
    Depo.clear_config!
  end
end
