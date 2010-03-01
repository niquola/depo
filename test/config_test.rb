require File.dirname(__FILE__) + '/test_helper.rb'

Depo.configure do
  root 'public'
  author 'niquola@gmail.com'
  themes ['tundra','verdugo']

  environments do
    developmentDjConfig 'parseOnLoad:true;isDebug:true;'
    productionDjConfig 'parseOnLoad:true;isDebug:false;'
  end

  build_options do
    cssOptimize 'comments.keepLines'
    optimize 'shrinksafe.keepLines'
    cssImportIgnore '../dijit.css'
    internStrings 'true'
  end

  build_profile do
    libs<< 'mylib'

    pages<< 'app.pages.admin'
    pages<< 'app.pages.chart'
    pages<< 'app.pages.nurse'
    pages<< 'app.pages.dashboard'
  end

  generators do
    head_of_test_page <<-HTML
    <link rel="stylesheet" href="#{Depo.config.src_path}/common.css" type="text/css" />
    HTML
  end

end

class DepoConfigureTest < GeneratorTest
  def test_roots
    config=Depo.config
    assert_equal('public', config.root)
    assert_equal('public/src', config.src_path)
    assert_equal('public/builds', config.builds_path)
    assert_equal('niquola@gmail.com', config.author)
    assert_match(/common.css/, config.generators.head_of_test_page )

    assert_equal(['tundra','verdugo'],config.themes)
    assert_equal('parseOnLoad:true;isDebug:true;',config.environments.developmentDjConfig)
    assert(config.build_profile.pages.include?('app.pages.admin'))
  end
end
