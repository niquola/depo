require File.dirname(__FILE__) + '/test_helper.rb'

Depo.configure {
  root 'public'
  author 'niquola@gmail.com'
  themes ['tundra','verdugo']

  build_options {
    cssOptimize 'comments.keepLines'
    optimize 'shrinksafe.keepLines'
    cssImportIgnore '../dijit.css'
    internStrings 'true'
  }

  build_profile {
    libs<< 'mylib'

    pages<< 'app.pages.admin'
    pages<< 'app.pages.chart'
    pages<< 'app.pages.nurse'
    pages<< 'app.pages.dashboard'
  }
}

class BuildProfileTest < GeneratorTest
  def test_basics
    Depo::Build.generate_profile(:rails_root=>fake_rails_root)
    assert_file 'tmp/dojo_build_profile.js'
    result = read('tmp/dojo_build_profile.js')
    puts result
    assert_match(/test\/rails_root\/public\/src\/mylib/, result)
  end
end
